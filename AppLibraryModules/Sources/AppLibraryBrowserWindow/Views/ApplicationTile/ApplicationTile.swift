import AppLibraryCommon
import AppLibraryRuntimeModelViews
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

struct ApplicationTile: View {
	@Environment(\.libraryLayout) private var libraryLayout

	@Environment(\.isFocused) private var isFocused

	@ObservedObject private var application: ApplicationModel

	public init(for application: ApplicationModel) {
		self.application = application
	}

	public var body: some View {
		Button(action: application.openLatest) {
			ApplicationLabel(for: application)
		}
		.background(isFocused ? Color.accentColor : Color.clear)

		.focusable()
		.focusEffectDisabled()

		.contextMenu {
			ContextMenu(for: application)
		}

		.id(ApplicationModelIdentifier(application))
		.applicationModelIdentifier(application)
	}
}