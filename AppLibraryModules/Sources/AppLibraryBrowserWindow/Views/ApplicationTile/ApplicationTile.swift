import AppLibraryCommon
import AppLibraryRuntimeModelViews
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

struct ApplicationTile: View {
	@Environment(\.libraryLayout) private var libraryLayout

	@ObservedObject private var application: ApplicationModel

	public init(for application: ApplicationModel) {
		self.application = application
	}

	public var body: some View {
		Button(action: application.openLatest) {
			libraryLayout.appTileStyle.makeBody(
				configuration: AnyApplicationTileStyle.Configuration(
					label: label,
					icon: icon
				)
			)
		}
		.focusable()
		.focusEffectDisabled()
		.contextMenu {
			ContextMenu(for: application)
		}
		.id(ApplicationModelIdentifier(application))
		.applicationModelIdentifier(application)
	}
}

// MARK: - Supporting Views

private extension ApplicationTile {
	var label: some View {
		Text(verbatim: application.displayName)
			.truncationMode(.tail)
			.help(application.displayName)
	}

	var icon: some View {
		Image(applicationIcon: application)
			.resizable()
			.aspectRatio(contentMode: .fit)
	}
}
