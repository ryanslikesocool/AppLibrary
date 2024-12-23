import Foundation
import NSMetadataToolbox
import OSLog
import UniformTypeIdentifiers

public extension ApplicationCache {
	func reload(searchScopes: [URL]) {
		Task {
			await reload(searchScopes: searchScopes)
		}
	}

	func reload(searchScopes: [URL]) async {
		guard case .idle = state else {
			return
		}

		let delegate = self.delegate ?? DefaultApplicationCacheDelegate.shared

		let task = createReloadCacheTask(delegate: delegate, searchScopes: searchScopes)
		state = .loading(task: task)

//		await Task.yield() // TODO: yield?

		await task.value

		state = .idle

		delegate.applicationCache(didFinishQuery: applications)
	}

	private func createReloadCacheTask(delegate: ApplicationCacheDelegate, searchScopes: [URL]) -> Task<Void, Never> {
		// TODO: handle task cancellation
		Task {
			Self.logger.info("Starting metadata query.")

			let query = NSMetadataQuery()
			query.searchScopes = searchScopes
			query.predicate = Self.metadataQueryPredicate
			query.groupingAttributes = Self.metadataQueryGroupingAttributes

			await query.gatherResults()

//			await Task.yield() // TODO: yield?

			self.applications = delegate.applicationCache(
				processQueryResults: Self.queryResultsAsApplications(query)
			)

			Self.logger.info("Finished metadata query with \(self.applications.count) processed result(s).")
		}
	}

	private static func queryResultsAsApplications(_ query: NSMetadataQuery) -> [ApplicationModel] {
		assert(query.delegate == nil)

		Logger.module.info("Processing \(query.resultCount) metadata query result(s).")

		return query.groupedResults
			.compactMap { group -> ApplicationModel? in
				assert(group.attribute == Self.metadataQueryGroupingAttributes[0])

				guard let bundleIdentifier = group.value as? String else {
					return nil
				}

				let applications: [ApplicationInstance] = group.results
					.compactMap { element -> ApplicationInstance? in
						if let element = element as? NSMetadataItem {
							try? ApplicationInstance(metadataItem: element)
						} else {
							nil
						}
					}

				return ApplicationModel(bundleIdentifier: bundleIdentifier, instances: applications)
			}
	}
}

// MARK: - Constants

private extension ApplicationCache {
	/// An array of attribute keys that determine how query results are grouped.
	static let metadataQueryGroupingAttributes: [String] = [
		NSMetadataAttribute.CFBundleIdentifierKey.attributeKey,
	]

	static let metadataQueryPredicate: NSPredicate! = {
		// NOTE: We can't use the #Predicate macro because it doesn't support `NSMetadataItem.value(forAttribute:)`
		// See the
		// [official documentation](https://developer.apple.com/documentation/foundation/nspredicate/4162324-init#discussion)
		// for more information.

		let contentTypeKey: String = NSMetadataAttribute.ContentTypeKey.attributeKey
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
	}()
}
