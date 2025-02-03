import AppLibraryCommon
import SwiftUI

extension AppInfoSection {
	struct AppIcon: View {
		public init() { }

		public var body: some View {
			Image(nsImage: .appIcon)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: Self.width)
		}
	}
}

// MARK: - Constants

private extension AppInfoSection.AppIcon {
	static let width: CGFloat? = 128
}
