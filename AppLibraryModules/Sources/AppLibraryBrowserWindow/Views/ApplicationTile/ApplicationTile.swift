import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

struct ApplicationTile: View {
	@Environment(\.isFocused) private var isFocused
	@Environment(\.libraryLayout) private var libraryLayout

	@ObservedObject private var application: ApplicationModel

	public init(for application: ApplicationModel) {
		self.application = application
	}

	public var body: some View {
		Button(action: application.openLatest) {
			ApplicationLabel(for: application)
		}
		.background(isFocused ? Self.focusedBackgroundColor : Self.unfocusedBackgroundColor)

		.focusable()
		.focusEffectDisabled()

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
	static var unfocusedBackgroundColor: Color { .clear }
	static var focusedBackgroundColor: Color { .accentColor }
}
