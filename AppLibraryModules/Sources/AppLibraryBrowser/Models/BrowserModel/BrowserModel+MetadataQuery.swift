import AppKit
import AppLibraryStorage
import AsyncNSMetadataQuery
import OSLog
import UniformTypeIdentifiers

@MainActor
extension BrowserModel {
	func refreshApps() {
		switch state {
			case .loading: return
			default: break
		}

		do {
			let metadataQuery = try createMetadataQuery()
			Logger.module.debug("Refreshing apps.")
			start(query: metadataQuery)
		} catch {
			state = .failed(reason: error)
		}

		func getSearchScopes() throws(BrowserError) -> [URL] {
			let searchScopes = LocationSettings.shared.searchScopes
			guard !searchScopes.isEmpty else {
				throw .noSearchScopes
			}
			return Array(searchScopes)
		}

		func createMetadataQuery() throws(BrowserError) -> NSMetadataQuery {
			let searchScopes = try getSearchScopes()

			let query = NSMetadataQuery()
			query.searchScopes = searchScopes
			query.predicate = Self.searchPredicate
			return query
		}

		func start(query: NSMetadataQuery) {
			let task = Task {
				await query.gatherResults()
				complete(query: query)
			}
			state = .loading(task: task)
		}

		func complete(query: NSMetadataQuery) {
			let applications = Self.processApplications(query)

			apps = applications
			state = if applications.isEmpty {
				.failed(reason: .noApps)
			} else {
				.complete
			}

			Logger.module.debug("""
			Finished refreshing applications.
			""")
		}
	}
}

// MARK: - Process Metadata

@MainActor
private extension BrowserModel {
	static func processApplications(
		_ query: NSMetadataQuery
	) -> [Application] {
		query.results
			.compactMap { element in
				if let element = element as? NSMetadataItem {
					try? Application(metadata: element)
				} else {
					nil
				}
			}
			.reduce(
				into: [ApplicationIdentifier: Application]()
			) { partialResult, element in
				if var existingApp = partialResult[element.id] {
					// already exists.  resolve merge conflict
					var element = element
					if
						let existingCreationDate = existingApp.creationDate,
						let newCreationDate = element.creationDate,
						newCreationDate < existingCreationDate
					{
						partialResult[element.id] = element
					}
				} else {
					// doesn't exist.  push
					partialResult[element.id] = element
				}
			}
			.map(\.value)
			.sorted(using: .localizedStandard(\.displayName))
	}
}

// MARK: - Constants

private extension BrowserModel {
	static var searchPredicate: NSPredicate {
		let contentTypeKey: String = NSMetadataItemContentTypeKey
		let desiredContentType = UTType.applicationBundle.identifier

		// TODO: figure out why format with arguments throws an Obj-C exception
//		let format: String = "%@ == '%@'"

		return NSPredicate(format: "\(contentTypeKey) == '\(desiredContentType)'")
	}
}
