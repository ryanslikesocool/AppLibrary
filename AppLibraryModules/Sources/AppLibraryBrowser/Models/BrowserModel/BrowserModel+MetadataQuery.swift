import AppKit
import AppLibraryStorage
import OSLog

@MainActor
extension BrowserModel {
	func refreshApps() {
		switch state {
			case .loading: return
			default: break
		}

		let asynchronous: Bool = true

		do {
			let metadataQuery = try Self.createMetadataQuery()
			Logger.module.debug("Refreshing apps (\(asynchronous ? "async" : "classic"))")
			start(query: metadataQuery)
		} catch {
			state = .failed(reason: error)
		}

		func start(query: NSMetadataQuery) {
			if asynchronous {
				refreshApps_async(query: query)
			} else {
				refreshApps_classic(query: query)
			}
		}
	}

	private func refreshApps_classic(query: NSMetadataQuery) {
		do {
			let metadataQuery = try startMetadataQuery()
			state = .loading(metadataQuery)
		} catch {
			state = .failed(reason: error)
		}

		func startMetadataQuery() throws(BrowserError) -> MetadataQuery {
			do {
				let metadataQuery = MetadataQuery()
				try metadataQuery.start(query: query, completionHandler: processMetadata)
				return metadataQuery
			} catch {
				throw BrowserError.queryFailure(error)
			}
		}
	}

	private func refreshApps_async(query: NSMetadataQuery) {
		let metadataQuery = MetadataQuery()
		state = .loading(metadataQuery)

		Task {
			do {
				try await metadataQuery.run(query: query)
				processMetadata(query: query)
			} catch {
				Logger.module.error("""
				Failed to complete metadata query:
				- Error: \(error)
				""")
			}
		}
	}
}

// MARK: - Utility

@MainActor
private extension BrowserModel {
	static func getSearchScopes() throws(BrowserError) -> [URL] {
		let searchScopes = LocationSettings.shared.searchScopes
		guard !searchScopes.isEmpty else {
			throw .noSearchScopes
		}
		return Array(searchScopes)
	}

	static func createMetadataQuery() throws(BrowserError) -> NSMetadataQuery {
		let searchScopes = try Self.getSearchScopes()

		let query = NSMetadataQuery()
		query.searchScopes = searchScopes
		query.predicate = Self.searchPredicate
		return query
	}
}

// MARK: - Process Metadata

@MainActor
private extension BrowserModel {
	func processMetadata(query: NSMetadataQuery) {
		let applications = Self.processApplications(query)

		apps = applications
		state = if applications.isEmpty {
			.failed(reason: .noApps)
		} else {
			.complete
		}

		Logger.module.info("""
		Finished refreshing applications.
		""")
	}

	static func processApplications(
		_ query: NSMetadataQuery
	) -> [Application] {
		query.results
			.compactMap { element in
				if let element = element as? NSMetadataItem {
					Application(metadata: element)
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
		let desiredContentType: String = "com.apple.application-bundle"

		// TODO: figure out why format with arguments throws an Obj-C exception
//		let format: String = "%@ == '%@'"

		return NSPredicate(format: "\(contentTypeKey) == '\(desiredContentType)'")
	}
}
