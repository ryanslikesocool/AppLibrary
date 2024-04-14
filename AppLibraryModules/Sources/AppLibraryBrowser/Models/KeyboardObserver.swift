import AppKit
import AppLibraryStorage
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
		if
			matchSearchShortcut(in: event)
			|| matchRefreshShortcut(in: event)
			|| matchEscapeKey(in: event)
			|| matchReturnKey(in: event)
			|| matchArrowKey(in: event)
			|| matchAlphanumericKey(in: event)
		{
			return nil
		}

		return event
	}
}

private extension KeyboardObserver {
	// (command + f) -> (activate search)
	func matchSearchShortcut(in event: NSEvent) -> Bool {
		// TODO: how to localize "f"?
		guard matchingKeyboardShortcut(event, key: "f", modifier: .command) else {
			return false
		}

		model.onSearchShortcut()
		return true
	}

	// (command + r) -> (refresh apps)
	func matchRefreshShortcut(in event: NSEvent) -> Bool {
		// TODO: how to localize "r"?
		guard matchingKeyboardShortcut(event, key: "r", modifier: .command) else {
			return false
		}

		model.onRefreshShortcut()
		return true
	}

	// (escape) -> (dismiss + clear search) | (dismiss window)
	func matchEscapeKey(in event: NSEvent) -> Bool {
		guard matchingKeyboardShortcut(event, keyCode: Self.escapeKey, modifier: []) else {
			return false
		}

		model.onEscapeKey()
		return true
	}

	// (return) -> (dismiss search)
	func matchReturnKey(in event: NSEvent) -> Bool {
		matchingKeyboardShortcut(event, keyCode: Self.returnKey, modifier: [])
			&& model.onReturnKey()
	}

	// (arrow keys) -> (navigate)
	func matchArrowKey(in event: NSEvent) -> Bool {
		guard
			let direction = NavigationDirection(keyCode: event.keyCode),
			!model.isSearchFocused || direction.isVertical
		else {
			return false
		}

		model.onArrowKey(direction)
		return true
	}

	// (characters) -> (scroll to character)
	func matchAlphanumericKey(in event: NSEvent) -> Bool {
		guard let characters = event.charactersIgnoringModifiers else {
			return false
		}

		return model.onAlphanumericKey(characters)
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

// MARK: - Constants

private extension KeyboardObserver {
	static let escapeKey: UInt16 = 0x35
	static let returnKey: UInt16 = 0x24
}
