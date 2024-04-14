import AppLibraryStorage
import SwiftUI

struct AppTile: View {
	@Environment(\.libraryLayout) private var libraryLayout

	@ObservedObject private var browserModel: BrowserModel = .shared

	let application: Application

	var body: some View {
		Button(action: application.open) {
			switch libraryLayout {
				case .list: ListDisplay(application: application)
				case .grid: GridDisplay(application: application)
			}
		}
		.contextMenu(menuItems: contextMenu)
		.focusable()
		.id(application.id)
	}
}

// MARK: - Supporting Views

private extension AppTile {
	@ViewBuilder func contextMenu() -> some View {
		Section {
			Button("Open", action: application.open)
		}
		Section {
			Button("Hide", action: application.hide)
			Button("Show in Finder", action: application.showInFinder)
		}
	}
}
