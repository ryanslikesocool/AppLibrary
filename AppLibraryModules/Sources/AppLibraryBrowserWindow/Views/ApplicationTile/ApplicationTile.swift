import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationTile: View {
	@Environment(\.libraryLayout) private var libraryLayout
//	@Environment(\.dismissWindow) private var dismissWindow

	@ObservedObject private var application: ApplicationModel

	@FocusState.Binding private var focusState: BrowserFocusElement?

	private var isFocused: Bool {
		focusState == .application(application)
	}

	public init(
		for application: ApplicationModel,
		focusState: FocusState<BrowserFocusElement?>.Binding
	) {
		self.application = application
		_focusState = focusState
	}

	public var body: some View {
		Button(action: buttonAction) {
			ApplicationLabel(for: application)
		}
		.contentShape(Self.backgroundShape)

		.focusable(interactions: [.edit, .activate]) // TODO: use `.activate` only when not using keyboard
		.focusEffectDisabled()
		.focused($focusState, equals: .application(application))

//		.onKeyPress(.return) {
//			// TODO: open application
//		}

		.background(
			isFocused ? Self.focusedBackgroundStyle : Self.unfocusedBackgroundStyle,
			in: Self.backgroundShape // Ideally, we'd use `.buttonBorder`, but the custom value matches app icons better.
		)

		.inputCommandRepublisher()

//		.draggable(application.latestInstance?.url) {
//			ApplicationIcon(for: application)
//		}

		.contextMenu {
			ContextMenu(for: application)
		}

		.id(ApplicationModelIdentifier(application))
		.applicationModelIdentifier(application)
	}
}

// MARK: - Constants

private extension ApplicationTile {
	static let backgroundShape: some InsettableShape = .rect(cornerRadius: 14)

	static var unfocusedBackgroundStyle: AnyShapeStyle {
		AnyShapeStyle(
			.clear
		)
	}

	static var focusedBackgroundStyle: AnyShapeStyle {
		AnyShapeStyle(
			.selection
		)
	}
}

// MARK: - Functions

private extension ApplicationTile {
	func buttonAction() {
		application.openLatest()

		Event.windowVisibility.send(.browser, .dismiss)
	}
}
