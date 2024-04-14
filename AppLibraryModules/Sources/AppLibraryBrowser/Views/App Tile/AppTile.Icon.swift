import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct Icon: View {
		@Environment(\.libraryLayout) private var libraryLayout
		@Environment(\.isFocused) private var isFocused

		private let icon: NSImage

		private var shadow: Shadow { isFocused ? Self.focusedShadow : Self.unfocusedShadow }
		private var scale: Double { isFocused ? Self.focusedScale : Self.unfocusedScale }

		init(application: borrowing Application) {
			icon = application.getIcon()
		}

		var body: some View {
			Image(nsImage: icon)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(height: libraryLayout.iconSize)
				.scaleEffect(scale)
				.shadow(color: Color.black.opacity(shadow.opacity), radius: shadow.radius, y: shadow.y)
				.animation(.interactiveSpring, value: isFocused)
		}
	}
}

// MARK: - Constants

extension AppTile.Icon {
	static let unfocusedShadow: Shadow = (0, 0, 0)
	static let focusedShadow: Shadow = (0.5, 8, 4)

	static let unfocusedScale: Double = 1.0
	static let focusedScale: Double = 1.25
}
