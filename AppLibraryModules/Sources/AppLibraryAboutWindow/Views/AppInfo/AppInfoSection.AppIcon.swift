import AppLibraryCommon
import SwiftUI

extension AppInfoSection {
	struct AppIcon: View {
		public init() { }

		public var body: some View {
			Image(nsImage: .appIcon)
				.resizable()
//				.aspectRatio(contentMode: Self.iconAspectContentMode)
				.frame(width: Self.width, height: Self.height)
		}
	}
}

// MARK: - Constants

private extension AppInfoSection.AppIcon {
	//	static let aspectContentMode: ContentMode = .fit
	static let width: CGFloat? = 128
	static var height: CGFloat? { width }
}
