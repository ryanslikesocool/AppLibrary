import AppKit
import AppLibrarySettings

extension BrowserCache {
	func reloadApps(_: Notification) {
		reloadApps()
	}

	func reloadApps() {
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

		query.searchScopes = AppSettings.shared.directories.searchScopes
		query.predicate = Self.searchPredicate

		activeMetadataQuery = query

		if !query.start() {
			stopQuery(query)
			queryState = .failed(reason: .queryStartFailure)
		}
	}

	private func finishMetadataQuery(notification: Notification) {
		guard let query = notification.object as? NSMetadataQuery else {
			fatalError("Received \(notification.name) from an invalid object.")
		}

		processMetadata(query: query)
		stopQuery(query)
	}

	private func processMetadata(query: NSMetadataQuery) {
		let metadata = query.results.compactMap { $0 as? NSMetadataItem }

		let sourceApps: [Application] = metadata.compactMap(Application.init)
		var filteredApps: [Application] = []
		filteredApps.reserveCapacity(sourceApps.count)

		for app in sourceApps {
			guard let existingIndex = filteredApps.firstIndex(where: { $0.bundleIdentifier == app.bundleIdentifier }) else {
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
		}
		filteredApps.sort(by: { $0.displayName.lowercased() < $1.displayName.lowercased() })

		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			self.apps = filteredApps
			queryState = .complete
		}
	}

	private func stopQuery(_ query: NSMetadataQuery) {
		if query.isStarted {
			query.stop()
		}
		activeMetadataQuery = nil

		NotificationCenter.default.removeObserver(finishMetadataQuery, name: .NSMetadataQueryDidFinishGathering, object: nil)
	}
}

// MARK: - Constants

extension BrowserCache {
	private static let searchPredicate: NSPredicate = NSPredicate(format: "\(contentTypeKey) == '\(desiredContentType)'")

	static let contentTypeKey: String = NSMetadataItemContentTypeKey
	static let desiredContentType: String = "com.apple.application-bundle"
}
