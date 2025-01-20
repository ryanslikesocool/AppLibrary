import AppLibraryCommon
import OSLog
import SwiftUI

struct InputReceiver: ViewModifier {
//	@Environment(\._focusSystem) private var focusSystem: _FocusSystem

	@EnvironmentObject private var browserModel: BrowserModel

	@FocusState.Binding private var focusState: BrowserFocusElement?

	fileprivate init(focusState: FocusState<BrowserFocusElement?>.Binding) {
		_focusState = focusState
	}

	public func body(content: Content) -> some View {
		content

			.background {
				EmptyView()
					.focusable()

					// NOTE: If the argument for this modifier equals the value for the `defaultFocus` modifier, stuff breaks.
					// Declaring an extra case, different from the `defaultFocus`, seems to work for some reason.
					.focused($focusState, equals: .invalid)

					.inputCommandRepublisher()
			}

			.defaultFocus($focusState, nil)

			.onReceive(Event.activateSearch, perform: onReceiveActivateSearchCommand)
			.onReceive(Event.refreshApps, perform: onReceiveRefreshApplicationsCommand)
			.onReceive(Event.moveCommand, perform: onReceiveMoveCommand)
			.onReceive(Event.submitCommand, perform: onReceiveSubmitCommand)
			.onReceive(Event.exitCommand, perform: onReceiveExitCommand)
	}
}

// MARK: - Constants

private extension InputReceiver {
	nonisolated static let logger: Logger = Logger(category: Self.self)
}

// MARK: - Functions

private extension InputReceiver {
	func onReceiveActivateSearchCommand() {
		Self.logger.debug("Received \"activate search\" command.")

		focusState = .search
	}

	func onReceiveRefreshApplicationsCommand() {
		Self.logger.debug("Received \"refresh applications\" command.")

		browserModel.refreshApps()
	}

	func onReceiveMoveCommand(direction: MoveCommandDirection) {
		Self.logger.debug("Received \"move\" command.")
		// TODO: handle event
	}

	func onReceiveSubmitCommand() {
		Self.logger.debug("Received \"submit\" command.")

		// NOTE: `onSubmit` modifier only seems to support text fields and search fields.

		switch focusState {
			case .search?:
				browserModel.onSubmitSearch()
			case let .application(applicationModelIdentifier)?:
				// TODO: handle event
				break
			case .invalid?,
			     nil:
				break
		}
	}

	func onReceiveExitCommand() {
		Self.logger.debug("Received \"exit\" command.")

		switch focusState {
			case .search?:
				focusState = nil
			case .application?,
			     .invalid?,
			     nil:
				// TODO: dismiss window
				break
		}
	}
}

// MARK: - Convenience

extension View {
	func inputReceiver(focusState: FocusState<BrowserFocusElement?>.Binding) -> some View {
		modifier(InputReceiver(focusState: focusState))
	}

	func inputCommandRepublisher() -> some View {
		onMoveCommand(perform: Event.moveCommand.send)
			.onSubmit(Event.submitCommand.send)
			.onExitCommand(perform: Event.exitCommand.send)
	}
}
