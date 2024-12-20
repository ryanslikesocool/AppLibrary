import MetadataQueryToolbox
import Foundation
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
//			let queryDelegate = MetadataQueryDelegate()
			query.searchScopes = searchScopes
			query.predicate = Self.metadataQueryPredicate
//			query.delegate = queryDelegate

			await query.gatherResults()

//			await Task.yield() // TODO: yield?

			var applications = Self.queryResultsAsApplications(query)
			applications = delegate.applicationCache(processQueryResults: applications)
			self.applications = applications

			Self.logger.info("Finished metadata query with \(applications.count) processed result(s).")
		}
	}

//	private static func queryResultsAsApplications(_ query: NSMetadataQuery) -> [Application] {
//		assert(type(of: query.delegate) == Optional<MetadataQueryDelegate>.self)
//
//		return query.results.compactMap { element in
//			element as? Application
//		}
//	}

	private static func queryResultsAsApplications(_ query: NSMetadataQuery) -> [Application] {
		assert(query.delegate == nil)

		Logger.module.info("Processing \(query.results.count) metadata query result(s).")

		return query.results
			.compactMap { element -> Application? in
				if let element = element as? NSMetadataItem {
					try? Application(metadata: element)
				} else {
					nil
				}
			}
	}
}

// MARK: - NSMetadataQueryDelegate

//private extension ApplicationCache {
//	final class MetadataQueryDelegate: NSObject, NSMetadataQueryDelegate {
//		public func metadataQuery(_ query: NSMetadataQuery, replacementObjectForResultObject result: NSMetadataItem) -> Any {
//			(try? Application(metadata: result)) as Any
//		}
//	}
//}

// MARK: - Constants

private extension ApplicationCache {
	static let metadataQueryPredicate: NSPredicate = {
		let contentTypeKey: String = NSMetadataItemContentTypeKey
		let desiredContentType = UTType.applicationBundle.identifier

		// TODO: figure out why format with arguments throws an Obj-C exception
//		let format: String = "%@ == '%@'"

		let format: String = "\(contentTypeKey) == '\(desiredContentType)'"

		return NSComparisonPredicate(format: format)
//		return NSPredicate(format: format)
	}()
}
