import SwiftUI

final class BrowserCache: ObservableObject {
	static let shared: BrowserCache = BrowserCache()

	@Published var apps: [Application]
	@Published var queryState: BrowserQueryState?

	var activeMetadataQuery: NSMetadataQuery?

	private var eventMonitor: Any?
	lazy var keyboardKeyEventPublisher: NotificationCenter.Publisher = NotificationCenter.Publisher(center: .default, name: Self.keyboardKeyEvent, object: self)

	private init() {
		apps = []
		eventMonitor = nil
		NotificationCenter.default.addObserver(forName: Self.reloadApps, object: nil, queue: nil, using: reloadApps)
		reloadApps()
	}
}

// MARK: - Constants

extension BrowserCache {
	static let reloadApps: Notification.Name = Notification.Name("AppLibrary.BrowserCache.ReloadApps")

	static let eventValueKey: String = "string"
	static let keyboardKeyEvent: Notification.Name = Notification.Name("AppLibrary.BrowserCache.OnKeyboardKey")
}

// MARK: - Event Monitor

extension BrowserCache {
	func createEventMonitor() {
		eventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: onEvent)
	}

	func destroyEventMonitor() {
		if let eventMonitor {
			NSEvent.removeMonitor(eventMonitor)
			self.eventMonitor = nil
		}
	}

	private func onEvent(_ event: NSEvent) -> NSEvent? {
		if let characters = event.characters {
			NotificationCenter.default.post(name: Self.keyboardKeyEvent, object: self, userInfo: [Self.eventValueKey: characters])
			return nil
		}

		return event
	}

	func jumpTo(string: String, in proxy: ScrollViewProxy) {
		let lowercasedString = string.lowercased()
		guard let firstResult = apps.first(where: { $0.displayName.lowercased().starts(with: lowercasedString) }) else {
			return
		}
		proxy.scrollTo(firstResult.id, anchor: .top)
	}
}
