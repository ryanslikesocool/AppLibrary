import Cocoa

final class AppState: ObservableObject {
	static let shared: AppState = AppState()

	@Published var apps: [ApplicationInformation]

	private init() {
		apps = []

		NotificationCenter.default.addObserver(forName: Self.reloadApps, object: nil, queue: nil, using: reloadApps)
	}
}

// MARK: - Apps

extension AppState {
	static let reloadApps: Notification.Name = Notification.Name("AppLibraryWindowController.ReloadApps")

	private func reloadApps(_: Notification) {
		let query: NSMetadataQuery = NSMetadataQuery()
		query.searchScopes = [URL](AppSettings.shared.directories.searchScopes)
		let pred: NSPredicate = NSPredicate(format: "kMDItemContentType == 'com.apple.application-bundle'")

		NotificationCenter.default.addObserver(forName: .NSMetadataQueryDidFinishGathering, object: nil, queue: .main, using: recieve)

		query.predicate = pred
		query.start()

		func recieve(notification: Notification) {
			NotificationCenter.default.removeObserver(recieve, name: .NSMetadataQueryDidFinishGathering, object: nil)
			let metadata = query.results.compactMap { $0 as? NSMetadataItem }
			process(metadata: metadata)
		}

		func process(metadata: [NSMetadataItem]) {
			apps = metadata.map { ApplicationInformation(metadata: $0) }
		}
	}
}
