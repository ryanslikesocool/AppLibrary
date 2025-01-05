import AppKit
import SwiftUI

extension BrowserModel: KeyboardObserverDelegate {
	func keyboardObserver(receivedKeyboardShortcut keyboardShortcut: KeyboardShortcut, _: KeyboardObserver) -> Bool {
		matchSearchShortcut(keyboardShortcut)
			|| matchRefreshShortcut(keyboardShortcut)
			|| matchCancelAction(keyboardShortcut)
			|| matchDefaultAction(keyboardShortcut)
			|| matchArrowKey(keyboardShortcut.key)
			|| matchAlphanumericKey(keyboardShortcut.key)
	}
}

// MARK: -

private extension BrowserModel {
	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	func matchSearchShortcut(_ keyboardShortcut: KeyboardShortcut) -> Bool {
		guard keyboardShortcut == .search else {
			return false
		}

		onSearchShortcut()

		return true
	}

	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	func matchRefreshShortcut(_ keyboardShortcut: KeyboardShortcut) -> Bool {
		guard keyboardShortcut == .refresh else {
			return false
		}

		onRefreshShortcut()

		return true
	}

	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	func matchCancelAction(_ keyboardShortcut: KeyboardShortcut) -> Bool {
		guard keyboardShortcut == .cancelAction else {
			return false
		}

		onEscapeKey()

		return true
	}

	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	func matchDefaultAction(_ keyboardShortcut: KeyboardShortcut) -> Bool {
		guard keyboardShortcut == .defaultAction else {
			return false
		}

		return onReturnKey()
	}

	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	func matchArrowKey(_ keyEquivalent: KeyEquivalent) -> Bool {
		guard keyEquivalent.character.isArrowKey else {
			return false
		}

		guard
			let direction = NavigationDirection(keyEquivalent: keyEquivalent),
			!isSearchDisplayed || direction.axis == .vertical
		else {
			return false
		}

		onArrowKey(direction)

		return true
	}

	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	func matchAlphanumericKey(_ keyEquivalent: KeyEquivalent) -> Bool {
		guard keyEquivalent.character.isAlphanumeric else {
			return false
		}

		return onAlphanumericKey(keyEquivalent.character)
	}
}