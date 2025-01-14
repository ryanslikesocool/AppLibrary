import AppLibraryCommon
import AppLibraryStorage
import Foundation
import NSMetadataToolbox
import OSLog
import UniformTypeIdentifiers

public extension ApplicationCache {
	/// - Parameters:
	///   - searchScopes:
	// Implicit `@MainActor`
	func reload(
		searchScopes: [URL]
	) {
		Task { // Implicit `@MainActor`
			await reload(searchScopes: searchScopes)
		}
	}

	/// - Parameters:
	///   - searchScopes:
	// Implicit `@MainActor`
	func reload(
		searchScopes: [URL]
	) async {
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

	/// - Parameters:
	///   - searchScopes:
	// Implicit `@MainActor`
	private func createReloadCacheTask(
		searchScopes: [URL]
	) -> Task<Void, Never> {
		Task { // Implicit `@MainActor`
			let query = NSMetadataQuery()
			query.searchScopes = searchScopes
			query.predicate = Self.metadataQueryPredicate
			query.groupingAttributes = Self.metadataQueryGroupingAttributes

			defer {
				// Perform cleanup when the scope exits.
				// TODO: Check if `defer` is called on task cancellation.
				query.stop()
			}

			let eventStream = query.eventStream()

			guard query.start() else {
				Self.logger.info("Failed to start metadata query.")
				return
			}
			Self.logger.info("Starting metadata query.")

			eventLoop: for await event in eventStream {
				Self.logger.debug("""
				Received metadata query event.
				- Event: \(String(describing: event))
				""")

				// TODO: Handle other metadata events

				switch event {
					case .didStartGathering:
						break
					case .didFinishGathering:
						self.applications = Self.processQueryResults(query, searchScopes: searchScopes)
						Self.logger.info("""
						Finished metadata query.
						- Processed Results: \(self.applications.count)
						""")
						break eventLoop
					case .gatheringProgress:
						break
					case .didUpdate:
						break
				}

				checkCancellation()
			}

			func checkCancellation() {
				// NOTE: Ideally, we'd use `withTaskCancellationHandler` instead of defining this function,
				// but `NSMetadataQuery` can't be captured in the `onCancel` closure.

//				await withTaskCancellationHandler {
//					/* event loop */
//				} onCancel: {
//					query.stop()
//				}

				// VALIDATE: Is this even correct?

				if Task.isCancelled {
					query.stop()
				}
			}
		}
	}

	/// - Parameters:
	///   - query:
	///   - searchScopes:
	private static func processQueryResults(
		_ query: NSMetadataQuery,
		searchScopes: borrowing [URL]
	) -> OrderedDictionary<ApplicationModelIdentifier, ApplicationModel> {
		logger.info("Processing \(query.resultCount) metadata query result(s).")

		let applicationModels = query.groupedResults
//			.compactMap(processGroup(_:)) // TODO: Figure out why this wants to `throw`
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
//				.compactMap(processResult(_:)) // TODO: Figure out why this wants to `throw`
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
		// [official documentation]( https://developer.apple.com/documentation/foundation/nspredicate/4162324-init#discussion )
		// for more information.

		/// The primary predicate that includes application items.
		let contentTypePredicate = NSComparisonPredicate(
			attributeKey: NSMetadataAttributeKeys.ContentType.self,
			equals: UTType.applicationBundle.identifier
		)

		return NSCompoundPredicate(type: .and, subpredicates: [
			contentTypePredicate,
			createSupportFileExclusionPredicate(),
		])

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
