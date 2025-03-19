import AppLibraryCommon
import SwiftUI

extension AppInfoSection {
	struct AppName: View {
		public init() { }

		public var body: some View {
			Text(verbatim: NSApplication.shared.applicationName)
				.font(Self.font)
		}
	}
}

// MARK: - Constants

private extension AppInfoSection.AppName {
	static var font: Font { .title.weight(fontWeight) }
	static var fontWeight: Font.Weight { .semibold }
}
