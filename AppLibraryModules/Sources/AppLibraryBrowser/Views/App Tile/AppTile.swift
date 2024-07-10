import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct AppTile: View {
	@Environment(\.libraryLayout) private var libraryLayout

	private let application: Application

	init(for application: Application) {
		self.application = application
	}

	var body: some View {
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
		.contextMenu { ContextMenu(for: application) }
		.id(application.id)
	}
}

private extension AppTile {
	func label() -> some View {
		Text(application.displayName)
			.truncationMode(.tail)
			.help(application.displayName)
	}

	func icon() -> some View {
		Image(nsImage: application.getIcon())
			.resizable()
			.aspectRatio(contentMode: .fit)
	}
}
