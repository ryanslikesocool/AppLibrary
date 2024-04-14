import AppKit
import AppLibraryStorage
import OSLog

extension BrowserModel {
	func refreshApps() {
		guard queryState != .loading else {
			return
		}
		guard !AppSettings.shared.directories.searchScopes.isEmpty else {
			queryState = .failed(reason: .noSearchDirectories)
			return
		}

		queryState = .loading

		let query = NSMetadataQuery()

		NotificationCenter.default.addObserver(forName: .NSMetadataQueryDidFinishGathering, object: query, queue: nil, using: finishMetadataQuery)

		query.searchScopes = Array(AppSettings.shared.directories.searchScopes)
		query.predicate = Self.searchPredicate

		activeMetadataQuery = query

		if !query.start() {
			stopQuery(query)
			queryState = .failed(reason: .queryStartFailure)
		}

		Logger.module.debug("Now reloading apps...")
	}
}

private extension BrowserModel {
	func finishMetadataQuery(notification: Notification) {
		guard let query = notification.object as? NSMetadataQuery else {
			preconditionFailure("Received \(notification.name) from an invalid object.")
		}

		processMetadata(query: query)
		stopQuery(query)
	}

	func processMetadata(query: NSMetadataQuery) {
		let metadata = query.results.compactMap { $0 as? NSMetadataItem }

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
		filteredApps.sort(by: { $0.displayName.localizedStandardCompare($1.displayName) == .orderedAscending })

		DispatchQueue.main.async { [weak self] in
			guard let self else {
				return
			}
			self.apps = filteredApps
			queryState = .complete
		}
	}

	func stopQuery(_ query: NSMetadataQuery) {
		if query.isStarted {
			query.stop()
		}
		activeMetadataQuery = nil

		NotificationCenter.default.removeObserver(finishMetadataQuery, name: .NSMetadataQueryDidFinishGathering, object: nil)
	}
}

// MARK: - Constants

extension BrowserModel {
	private static var searchPredicate: NSPredicate { NSPredicate(format: "\(contentTypeKey) == '\(desiredContentType)'") }

	static var contentTypeKey: String { NSMetadataItemContentTypeKey }
	static var desiredContentType: String { "com.apple.application-bundle" }
}
