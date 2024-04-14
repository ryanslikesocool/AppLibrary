import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct Label: View {
		@Environment(\.libraryLayout) private var libraryLayout
		private let text: String

		init(application: Application) {
			text = application.displayName
		}

		var body: some View {
			switch libraryLayout {
				case .list:
					content
				case .grid:
					content
						.lineLimit(2, reservesSpace: true)
			}
		}
	}
}

// MARK: - Supporting Views

private extension AppTile.Label {
	var content: some View {
		Text(text)
			.font(libraryLayout.font)
			.truncationMode(.tail)
			.help(text)
	}
}
