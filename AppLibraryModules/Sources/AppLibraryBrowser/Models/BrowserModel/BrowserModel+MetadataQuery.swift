import AppKit
import AppLibraryStorage
import OSLog

extension BrowserModel {
	@MainActor
	func refreshApps() {
		guard state != .loading else {
			return
		}
		let searchScopes = LocationSettings.shared.searchScopes

		guard !searchScopes.isEmpty else {
			state = .failed(reason: .noSearchScopes)
			return
		}

		state = .loading

		let query = NSMetadataQuery()

		NotificationCenter.default.addObserver(forName: .NSMetadataQueryDidFinishGathering, object: query, queue: nil, using: finishMetadataQuery)

		query.searchScopes = Array(searchScopes)
		query.predicate = Self.searchPredicate

		activeMetadataQuery = query

		if !query.start() {
			stopQuery(query)
			state = .failed(reason: .queryStartFailure)
		}

		Logger.module.debug("Now reloading apps...")
	}
}

private extension BrowserModel {
	@Sendable
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
	static let desiredContentType: String = "com.apple.application-bundle"
}
