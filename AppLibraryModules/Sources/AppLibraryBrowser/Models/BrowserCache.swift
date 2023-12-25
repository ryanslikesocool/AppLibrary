import SwiftUI

final class BrowserCache: ObservableObject {
	static let shared: BrowserCache = BrowserCache()

	@Published var apps: [Application]
	@Published var queryState: BrowserQueryState?

	var activeMetadataQuery: NSMetadataQuery?

	private init() {
		apps = []
		NotificationCenter.default.addObserver(forName: Self.reloadApps, object: nil, queue: nil, using: reloadApps)
		reloadApps()
	}
}

// MARK: - Constants

extension BrowserCache {
	static let reloadApps: Notification.Name = Notification.Name("AppLibraryWindowController.ReloadApps")
}
