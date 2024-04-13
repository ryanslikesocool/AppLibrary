import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct Icon: View {
		@Environment(\.libraryLayout) private var libraryLayout
		private let icon: NSImage

		init(application: borrowing Application) {
			icon = application.getIcon()
		}

		var body: some View {
			Image(nsImage: icon)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(height: libraryLayout.iconSize)
		}
	}
}
