import AppKit
import AppLibraryStorage
import OSLog

extension BrowserModel {
	@MainActor
	func refreshApps() {
		guard state != .loading else {
			return
		}

		do {
			let searchScopes = try validateSearchScopes()

			state = .loading

			try startQuery { query in
				query.searchScopes = searchScopes
				query.predicate = BrowserModel.searchPredicate
			}

			Logger.module.debug("Reloading apps...")
		} catch {
			state = .failed(reason: error)
		}

		func validateSearchScopes() throws(BrowserError) -> [URL] {
			let searchScopes = LocationSettings.shared.searchScopes
			guard !searchScopes.isEmpty else {
				throw .noSearchScopes
			}
			return Array(searchScopes)
		}

		func startQuery(configureQuery: (NSMetadataQuery) -> Void) throws(BrowserError) {
			do {
				try metadataQuery.start(configureQuery: configureQuery, completionHandler: processMetadata)
			} catch {
				throw BrowserError.queryFailure(error)
			}
		}
	}

	func processMetadata(query: NSMetadataQuery) {
		let metadata = query.results.compactMap { element in
			element as? NSMetadataItem
		}
		processMetadata(metadata: metadata)
	}

	func processMetadata(metadata: [NSMetadataItem]) {
		var sourceApps: [Application] = metadata.compactMap(Application.init)
		var filteredApps: [Application] = []
		filteredApps.reserveCapacity(sourceApps.count)

		for index in sourceApps.indices {
			var app: Application = sourceApps[index]
			guard let existingIndex = filteredApps.firstIndex(where: { $0.id == app.id }) else {
				filteredApps.append(app)
				continue
			}

			if
				let existingCreationDate = filteredApps[existingIndex].creationDate,
				let newCreationDate = app.creationDate,
				existingCreationDate < newCreationDate
			{
				filteredApps[existingIndex] = app
			}
			sourceApps[index] = app
		}
		filteredApps.sort(by: { lhs, rhs in
			lhs.displayName.localizedStandardCompare(rhs.displayName) == .orderedAscending
		})

		DispatchQueue.main.async { [weak self] in
			guard let self else {
				return
			}
			apps = filteredApps
			state = if filteredApps.isEmpty {
				.failed(reason: .noApps)
			} else {
				.complete
			}
		}
	}
}

// MARK: - Constants

extension BrowserModel {
	static let metadataQueryNotificationName: Notification.Name = .NSMetadataQueryDidFinishGathering

	static var searchPredicate: NSPredicate {
		let contentTypeKey: String = NSMetadataItemContentTypeKey
		let desiredContentType: String = "com.apple.application-bundle"

		// TODO: figure out why format with arguments throws an Obj-C exception
//		let format: String = "%@ == '%@'"

		return NSPredicate(format: "\(contentTypeKey) == '\(desiredContentType)'")
	}
}
