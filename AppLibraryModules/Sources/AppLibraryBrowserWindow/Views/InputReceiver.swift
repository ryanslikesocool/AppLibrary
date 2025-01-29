import AppLibraryCommon
import OSLog
import SwiftUI

struct InputReceiver: ViewModifier {
//	@Environment(\._focusSystem) private var focusSystem: _FocusSystem

	@EnvironmentObject private var browserModel: BrowserModel

	@Environment(\.libraryLayout) private var libraryLayout

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
					// Declaring an extra case, different from the on in `defaultFocus`, seems to work for some reason.
					// This also seemingly fixes issues where setting `focusState` to `nil` (instead of `default`) will break.
					.focused($focusState, equals: .default)

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
		Self.logger.debug("""
		Received command:
		- Type: activate search
		""")

		focusState = .search
	}

	func onReceiveRefreshApplicationsCommand() {
		Self.logger.debug("""
		Received command:
		- Type: refresh applications
		""")

		browserModel.refreshApps()
	}

	func onReceiveMoveCommand(direction: MoveCommandDirection) {
		Self.logger.debug("""
		Received command:
		- Type: move
		""")

		// TODO: figure out how to handle when `.search` is focused.

		switch (focusState, direction) {
			case (.default?, .right),
			     (.default?, .down),
			     (.search?, .down):
				// Set focus to the first application in the list.
				guard let application = browserModel.filteredApps.first else {
					break
				}
				focusState = .application(application)
			// TODO: force scroll view to jump to element
			case (.default?, .left),
			     (.default?, .up),
			     (.search?, .up):
				// Set focus to the last application in the list.
				guard let application = browserModel.filteredApps.last else {
					break
				}
				focusState = .application(application)
			// TODO: force scroll view to jump to element
			case (.application?, _):
				let applicationIndexOffset = direction.offset(for: libraryLayout)
			// TODO: set focus element
			default:
				break
		}
	}

	func onReceiveSubmitCommand() {
		Self.logger.debug("""
		Received command:
		- Type: submit
		""")

		// NOTE: `onSubmit` modifier only seems to support text fields and search fields.

		switch focusState {
			case .search?:
				guard !browserModel.searchQuery.isEmpty else {
					focusState = nil
					Logger.input.debug("\(#function): Search was focused, query was empty.")
					break
				}

				guard let bestMatch = browserModel.filteredApps.first else {
					Logger.input.debug("\(#function): Best match for search was not found.")
					break
				}

				bestMatch.openLatest()
				browserModel.searchQuery = ""
				Logger.input.debug("\(#function): Opening app for best match.")
			case let .application(applicationModelIdentifier)?:
				// TODO: handle event
				break
			case .default?,
			     nil:
				break
		}
	}

	func onReceiveExitCommand() {
		Self.logger.debug("""
		Received command:
		- Type: exit
		""")

		switch focusState {
			case .search?:
				focusState = .default
			case .application?,
			     .default?,
			     nil:
				Event.windowVisibility.send(.browser, .dismiss)
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
