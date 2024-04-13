import AppKit
import OSLog

final class KeyboardObserver {
	private unowned let model: BrowserModel

	private var modifierEventMonitor: Any?
	private var keyEventMonitor: Any?

	private var modifierFlags: NSEvent.ModifierFlags
	var isEventMonitorInitialized: Bool { modifierEventMonitor != nil && keyEventMonitor != nil }

	init(model: BrowserModel) {
		self.model = model

		modifierEventMonitor = nil
		keyEventMonitor = nil
		modifierFlags = []
	}

	func createEventMonitor() {
		guard !isEventMonitorInitialized else {
			return
		}
		/// Cannot combine event monitors for some reason.
		/// Obj-C exceptions get thrown when trying to access `NSEvent.characters`.
		modifierEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged, handler: onModifierEvent)
		keyEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: onKeyEvent)

		Logger.module.debug("Created event monitor.")
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

		Logger.module.debug("Destroyed event monitor.")
	}
}

// MARK: -

private extension KeyboardObserver {
	func onModifierEvent(_ event: NSEvent) -> NSEvent? {
		modifierFlags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
		return event
	}

	func onKeyEvent(_ event: NSEvent) -> NSEvent? {
		guard let characters = event.charactersIgnoringModifiers else {
			return event
		}

		searchShortcut: do { // (command + f) -> (activate search)
			// TODO: how to localize "f"?
			guard matchingKeyboardShortcut(event, key: "f", modifier: .command) else {
				break searchShortcut
			}

			model.onSearchShortcut()
			return nil
		}

		refreshShortcut: do { // (command + r) -> (refresh apps)
			// TODO: how to localize "r"?
			guard matchingKeyboardShortcut(event, key: "r", modifier: .command) else {
				break refreshShortcut
			}

			model.onRefreshShortcut()
			return nil
		}

		escapeKey: do { // (escape) -> (dismiss + clear search) | (dismiss window)
			guard matchingKeyboardShortcut(event, keyCode: 53, modifier: []) else {
				break escapeKey
			}

			model.onEscapeKey()
			return nil
		}

		returnKey: do { // (return) -> (dismiss search)
			guard
				matchingKeyboardShortcut(event, keyCode: 36, modifier: []),
				model.onReturnKey()
			else {
				break returnKey
			}

			return nil
		}

		characterKey: do { // (characters) -> (scroll to character)
			guard model.onAnyKey(characters) else {
				break characterKey
			}

			return nil
		}

		return event
	}
}

private extension KeyboardObserver {
	func matchingKeyboardShortcut(_ event: NSEvent, key: String, modifier: NSEvent.ModifierFlags) -> Bool {
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

	func matchingKeyboardShortcut(_ event: NSEvent, keyCode: CGKeyCode, modifier: NSEvent.ModifierFlags) -> Bool {
		event.keyCode == keyCode && modifierFlags == modifier
	}
}
