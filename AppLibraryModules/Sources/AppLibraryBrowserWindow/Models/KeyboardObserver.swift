import AppKit
import AppLibraryStorage
import OSLog
import SwiftUI

@MainActor
final class KeyboardObserver {
	public weak var delegate: KeyboardObserverDelegate?

	private var modifierEventMonitor: Any?
	private var keyEventMonitor: Any?

	private var modifierFlags: NSEvent.ModifierFlags

	public var isEventMonitorInitialized: Bool {
		modifierEventMonitor != nil && keyEventMonitor != nil
	}

	public init() {
		delegate = nil
		modifierEventMonitor = nil
		keyEventMonitor = nil
		modifierFlags = []
	}
}

// MARK: - Constants

extension KeyboardObserver {
	nonisolated static let logger = Logger(category: KeyboardObserver.self)
}

// MARK: - Event Monitors

extension KeyboardObserver {
	public var isEnabled: Bool {
		get { modifierEventMonitor != nil && keyEventMonitor != nil }
		set {
			guard isEnabled != newValue else {
				return
			}

			if newValue {
				createEventMonitors()
			} else {
				destroyEventMonitors()
			}
		}
	}

	private func createEventMonitors() {
		guard !isEventMonitorInitialized else {
			return
		}

		/// Cannot combine event monitors for some reason.
		/// Obj-C exceptions get thrown when trying to access `NSEvent.characters`.
		modifierEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged, handler: onModifierEvent)
		keyEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: onKeyEvent)

		Self.logger.debug("Created event monitors.")
	}

	private func destroyEventMonitors() {
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

		Self.logger.debug("Destroyed event monitors.")
	}
}

// MARK: - Event Observers

private extension KeyboardObserver {
	func onModifierEvent(_ event: NSEvent) -> NSEvent? {
		modifierFlags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
		return event
	}

	func onKeyEvent(_ event: NSEvent) -> NSEvent? {
		guard
			let delegate,
			let keyboardShortcut = Self.createKeyboardShortcut(event: event, modifierFlags: modifierFlags)
		else {
			return event
		}

		Self.logger.debug("Sending keyboard event: \(String(describing: keyboardShortcut))")

		return if delegate.keyboardObserver(receivedKeyboardShortcut: keyboardShortcut, self) {
			nil
		} else {
			event
		}
	}
}

// MARK: - Utility

private extension KeyboardObserver {
	static func createKeyboardShortcut(event: NSEvent, modifierFlags: NSEvent.ModifierFlags) -> KeyboardShortcut? {
		guard let keyEquivalent = KeyEquivalent(event.charactersIgnoringModifiers) else {
			return nil
		}
		let eventModifiers = EventModifiers(modifierFlags)

		return KeyboardShortcut(keyEquivalent, modifiers: eventModifiers)
	}
}
