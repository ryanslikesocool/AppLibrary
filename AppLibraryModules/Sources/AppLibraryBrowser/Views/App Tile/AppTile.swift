import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct AppTile: View {
	@Environment(\.libraryLayout) private var libraryLayout

	private let application: Application

	public init(for application: Application) {
		self.application = application
	}

	public var body: some View {
		Button(action: application.open) {
			libraryLayout.appTileStyle.makeBody(
				configuration: AnyAppTileStyle.Configuration(
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
		.id(application.id)
	}
}

// MARK: - Supporting Views

private extension AppTile {
	var label: some View {
		Text(verbatim: application.displayName)
			.truncationMode(.tail)
			.help(application.displayName)
	}

	var icon: some View {
		Image(nsImage: application.getIcon())
			.resizable()
			.aspectRatio(contentMode: .fit)
	}
}