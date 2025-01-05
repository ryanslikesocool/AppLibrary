import AppKit
import SwiftUI

// MARK: - Convenience

public extension KeyboardShortcut {
	init?(_ event: NSEvent) {
		guard let keyEquivalent = KeyEquivalent(event.charactersIgnoringModifiers) else {
			return nil
		}
		let eventModifiers = EventModifiers(event.modifierFlags)

		self.init(keyEquivalent, modifiers: eventModifiers)
	}
}

// MARK: - Constants

public extension KeyboardShortcut {
	// TODO: How do we localize keyboard shortcuts?
	static let search = Self("f", modifiers: [.command])

	// TODO: How do we localize keyboard shortcuts?
	static let refresh = Self("r", modifiers: [.command])
}