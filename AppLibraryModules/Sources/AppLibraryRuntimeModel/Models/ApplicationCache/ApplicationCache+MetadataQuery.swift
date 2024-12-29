import AppLibraryCommon
import AppLibraryStorage
import Foundation
import NSMetadataToolbox
import OSLog
import UniformTypeIdentifiers

public extension ApplicationCache {
	func reload(searchScopes: [URL]) {
		Task { // Implicit `@MainActor`
			await reload(searchScopes: searchScopes)
		}
	}

	// Implicit `@MainActor`
	func reload(searchScopes: [URL]) async {
		// TODO: Handle task cancellation

		guard case .idle = state else {
			return
		}

		let task = createReloadCacheTask(searchScopes: searchScopes)
		state = .loading(task: task)

		// We should `yield` here,
		// since this task is running on the main thread,
		// and we don't need result immediately.
		await Task.yield()

		await task.value

		state = .idle
	}

	// Implicit `@MainActor`
	private func createReloadCacheTask(searchScopes: [URL]) -> Task<Void, Never> {
		// TODO: Handle task cancellation

		Task { // Implicit `@MainActor`
			Self.logger.info("Starting metadata query.")

			let query = NSMetadataQuery()
			query.searchScopes = searchScopes
			query.predicate = Self.metadataQueryPredicate
			query.groupingAttributes = Self.metadataQueryGroupingAttributes

			await query.gatherResults()

			// We should `yield` here,
			// since this task is running on the main thread,
			// and we don't need result immediately.
			await Task.yield()

			self.applications = Self.processQueryResults(query, searchScopes: searchScopes)

			Self.logger.info("Finished metadata query with \(self.applications.count) processed result(s).")
		}
	}

	private static func processQueryResults(_ query: NSMetadataQuery, searchScopes: borrowing [URL]) -> OrderedDictionary<ApplicationModelIdentifier, ApplicationModel> {
		logger.info("Processing \(query.resultCount) metadata query result(s).")

		let applicationModels = query.groupedResults
//			.compactMap(processGroup(_:)) // TODO: Why does this want to `throw`?
			.compactMap { group -> ApplicationModel? in
				processGroup(group)
			}

		return OrderedDictionary(
			applicationModels.map { element in (ApplicationModelIdentifier(element), element) }
		) { oldValue, newValue in
			oldValue.formUnion(newValue)
			return oldValue
		}
		.sorted(by: \.displayName, comparator: .localizedStandard)

		func processGroup(_ group: NSMetadataQueryResultGroup) -> ApplicationModel? {
			assert(group.attribute == Self.metadataQueryGroupingAttributes[0])

			guard let bundleIdentifier = group.value as? String else {
				return nil
			}

			let applications: [ApplicationInstance] = group.results
//				.compactMap(processResult(_:)) // TODO: Why does this want to `throw`?
				.compactMap { element -> ApplicationInstance? in
					processResult(element)
				}

			return ApplicationModel(bundleIdentifier: bundleIdentifier, instances: applications)
		}

		func processResult(_ element: Any) -> ApplicationInstance? {
			guard
				let metadataItem = element as? NSMetadataItem,
				let applicationInstance = try? ApplicationInstance(metadataItem: metadataItem)
				// If we only want to include top-level results:
//				searchScopes.contains(applicationInstance.url.deletingLastPathComponent())
			else {
				return nil
			}

			return applicationInstance
		}
	}
}

// MARK: - Constants

private extension ApplicationCache {
	/// An array of attribute keys that determine how query results are grouped.
	nonisolated static let metadataQueryGroupingAttributes: [String] = [
		NSMetadataAttributeKeys.CFBundleIdentifier.attributeKey,
	]

	static let metadataQueryPredicate: NSPredicate = {
		// NOTE: We can't use the #Predicate macro because it doesn't support `NSMetadataItem.value(forAttribute:)`.
		// See the
		// [official documentation](https://developer.apple.com/documentation/foundation/nspredicate/4162324-init#discussion)
		// for more information.

		return NSCompoundPredicate(type: .and, subpredicates: [
			createContentTypePredicate(),
			createSupportFileExclusionPredicate(),
		])

		/// Create the primary predicate that includes application items.
		func createContentTypePredicate() -> NSPredicate {
			let contentTypeKey: String = NSMetadataAttributeKeys.ContentType.attributeKey
			let desiredContentType: UTType = UTType.applicationBundle

			// NOTE: We use different substitution arguments because we're
			// replacing a key path on the left side and an object value on the right side.
			// See
			// [NSHipster's Article](https://nshipster.com/nspredicate/#substitutions)
			// for more information.
			let format: String = "%K == %@"

			return NSPredicate(format: format, contentTypeKey, desiredContentType.identifier)

			// An alternative is to use the `init(fromMetadataQueryString:)`,
			// but the overload doesn't format the string for us,
			// so we have to do it ourselves.
			// The format string is a little less straightforward.
			// let format: String = #"%@ == "%@""#
			// NSPredicate(fromMetadataQueryString: String(format: format, contentTypeKey, desiredContentType.identifier))
		}

		/// Create a secondary predicate that excludes items that are considered support files.
		func createSupportFileExclusionPredicate() -> NSPredicate {
			let attributeKey: String = NSMetadataAttributeKeys.SupportFileType.attributeKey
			let excludingItem: String = "MDSystemFile"

			// TODO: Convert to set intersection
			// We want the functional equivalent of:
			// ```swift
			// !((try? metadataItem.value(forAttribute: .supportFileType))?.contains { item in
			//     excludingItems.contains(item)
			// } ?? false)
			// ```

			let format: String = "NOT %K CONTAINS %@"

			return NSPredicate(format: format, attributeKey, excludingItem)
		}
	}()
}
