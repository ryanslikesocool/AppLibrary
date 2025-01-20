import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

struct ApplicationTile: View {
//	@Environment(\.isFocused) private var isFocused
	@Environment(\.libraryLayout) private var libraryLayout

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
		Button(action: application.openLatest) {
			ApplicationLabel(for: application)
		}

		.focusable(interactions: [.edit])
		.focusEffectDisabled()
		.focused($focusState, equals: .application(application))

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
