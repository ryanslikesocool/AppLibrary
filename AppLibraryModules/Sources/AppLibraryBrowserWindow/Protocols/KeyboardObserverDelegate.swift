import SwiftUI

@MainActor
protocol KeyboardObserverDelegate: AnyObject {
	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	func keyboardObserver(receivedKeyboardShortcut keyboardShortcut: KeyboardShortcut, _ keyboardObserver: KeyboardObserver) -> Bool

//	/// - Returns: `true` if the event should be consumed; `false` otherwise.
//	func keyboardObserver(receivedKeyEquivalent keyEquivalent: KeyEquivalent, _ keyboardObserver: KeyboardObserver) -> Bool
}
