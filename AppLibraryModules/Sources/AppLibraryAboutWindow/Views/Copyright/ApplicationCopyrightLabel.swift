import BundleToolbox
import SwiftUI

extension CopyrightSection {
	struct ApplicationCopyrightLabel: View {
		private let text: String

		public init?() {
			guard let copyrightHolder = try? Bundle.main.object(forInfoDictionaryKey: .nsHumanReadableCopyright) else {
				return nil
			}
			let applicationName = NSApp.applicationName

			text = "\(applicationName) \(copyrightHolder)"
		}

		public var body: some View {
			Text(verbatim: text)
				.font(Self.font)
				.foregroundStyle(Self.foregroundStyle)
		}
	}
}

// MARK: - Constants

private extension CopyrightSection.ApplicationCopyrightLabel {
	static var font: Font { .caption }
	static var foregroundStyle: some ShapeStyle { .secondary }
}
