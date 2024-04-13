import AppLibraryStorage
import SwiftUI

final class BrowserCache: ObservableObject {
	static let shared: BrowserCache = BrowserCache()

	@Published var apps: [Application]
	@Published var queryState: BrowserQueryState?
	@Published var searchQuery: String
	@Published var isSearchFocused: Bool

	var activeMetadataQuery: NSMetadataQuery?

	private var modifierEventMonitor: Any?
	private var keyEventMonitor: Any?

	private var modifierFlags: NSEvent.ModifierFlags
	var isEventMonitorInitialized: Bool { modifierEventMonitor != nil && keyEventMonitor != nil }
	lazy var keyboardKeyEventPublisher: NotificationCenter.Publisher = NotificationCenter.Publisher(center: .default, name: Self.keyboardKeyEvent, object: self)

	private init() {
		apps = []
		searchQuery = ""
		isSearchFocused = false
		modifierEventMonitor = nil
		keyEventMonitor = nil
		modifierFlags = []

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
		guard !isEventMonitorInitialized else {
			return
		}
		/// Cannot combine event monitors for some reason.
		/// Obj-C exceptions get thrown when trying to access `NSEvent.characters`.
		modifierEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged, handler: onModifierEvent)
		keyEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: onKeyEvent)
	}

	func destroyEventMonitor() {
		guard isEventMonitorInitialized else {
			return
		}
		if let modifierEventMonitor {
			NSEvent.removeMonitor(modifierEventMonitor)
			self.modifierEventMonitor = nil
		}
		if let keyEventMonitor {
			NSEvent.removeMonitor(keyEventMonitor)
			self.keyEventMonitor = nil
		}
	}

	private func onModifierEvent(_ event: NSEvent) -> NSEvent? {
		modifierFlags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
		return event
	}

	private func onKeyEvent(_ event: NSEvent) -> NSEvent? {
		guard let characters = event.charactersIgnoringModifiers else {
			return event
		}

		activateSearch: do { // command + f
			// TODO: how to localize "f"?
			guard matchingKeyboardShortcut(event, key: "f", modifier: .command) else {
				break activateSearch
			}

			isSearchFocused = true
			return nil
		}

		startReload: do { // command + r
			// TODO: how to localize "r"?
			guard matchingKeyboardShortcut(event, key: "r", modifier: .command) else {
				break startReload
			}

			reloadApps()
			return nil
		}

		dismissWindow: do { // escape
			guard matchingKeyboardShortcut(event, keyCode: 53, modifier: []) else {
				break dismissWindow
			}
			
			if isSearchFocused {
				isSearchFocused = false
			} else {
				NSApplication.shared.hide(nil)
			}
			return nil
		}

		jumpToCharacter: do { // [character]
			guard !isSearchFocused else {
				break jumpToCharacter
			}

			NotificationCenter.default.post(name: Self.keyboardKeyEvent, object: self, userInfo: [Self.eventValueKey: characters])
			return nil
		}

		return event
	}

	private func matchingKeyboardShortcut(_ event: NSEvent, key: String, modifier: NSEvent.ModifierFlags) -> Bool {
		guard
			let characters = event.characters,
			characters.count == 1,
			characters == key,
			modifierFlags == modifier
		else {
			return false
		}
		return true
	}

	private func matchingKeyboardShortcut(_ event: NSEvent, keyCode: CGKeyCode, modifier: NSEvent.ModifierFlags) -> Bool {
		event.keyCode == keyCode && modifierFlags == modifier
	}
}

extension BrowserCache {
	func jumpTo(string: String, in proxy: ScrollViewProxy) {
		let lowercasedString = string.lowercased()
		guard let firstResult = apps.first(where: { $0.displayName.lowercased().starts(with: lowercasedString) }) else {
			return
		}
		proxy.scrollTo(firstResult.id, anchor: .top)
	}
}
