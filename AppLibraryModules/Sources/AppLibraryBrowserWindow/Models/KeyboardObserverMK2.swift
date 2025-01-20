//import AppKit
//import OSLog
//import SwiftUI
//
//final class KeyboardObserverMK2 {
//	private var eventMonitor: Any?
//
//	init() {
//		eventMonitor = nil
//	}
//}
//
//// MARK: - Constants
//
//private extension KeyboardObserverMK2 {
//	static let logger: Logger = Logger(category: KeyboardObserverMK2.self)
//}
//
//// MARK: -
//
//extension KeyboardObserverMK2 {
//	public var isEnabled: Bool {
//		get { eventMonitor != nil }
//		set {
//			guard isEnabled != newValue else {
//				return
//			}
//
//			if newValue {
//				createEventMonitor()
//			} else {
//				destroyEventMonitor()
//			}
//		}
//	}
//
//	private func createEventMonitor() {
//		guard !isEnabled else {
//			return
//		}
//
//		eventMonitor = NSEvent.addLocalMonitorForEvents(
//			matching: [.keyDown, .keyUp],
//			handler: handleEvent(_:)
//		)
//
//		Self.logger.info("Created event monitor.")
//	}
//
//	private func destroyEventMonitor() {
//		guard isEnabled else {
//			return
//		}
//
//		if let eventMonitor {
//			NSEvent.removeMonitor(eventMonitor)
//			self.eventMonitor = nil
//		}
//
//		Self.logger.info("Destroyed event monitor.")
//	}
//}
//
//// MARK: -
//
//private extension KeyboardObserverMK2 {
//	func handleEvent(_ event: NSEvent) -> NSEvent? {
//		guard let keyState = KeyState(event.type) else {
//			return event
//		}
//
//		return switch handleKey(state: keyState, event: event) {
//			case .ignore: event
//			case .consume: nil
//		}
//	}
//
//	/// - Returns: `true` if the event should be consumed; `false` otherwise.
//	func handleKey(state: KeyState, event: NSEvent) -> KeyEventResult {
//		if let keyEquivalent = KeyEquivalent(charactersIgnoringModifiersIn: event) {
//			if let direction = MoveCommandDirection(keyEquivalent: keyEquivalent) {
//				return handleArrowKey(state: state, direction: direction)
//			}
//		}
//
//		return .ignore
//	}
//
//	func handleArrowKey(state: KeyState, direction: MoveCommandDirection) -> KeyEventResult {
//		print(direction)
//		
//		return .ignore // TODO: replace with `.consume`
//	}
//}
