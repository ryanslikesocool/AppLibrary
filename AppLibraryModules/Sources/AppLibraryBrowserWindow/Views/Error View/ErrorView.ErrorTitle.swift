import SwiftUI

extension ErrorView {
	struct ErrorTitle: View {
		private let text: String

		public init?(error: BrowserError) {
			guard let text = error.errorDescription else {
				return nil
			}
			self.text = text
		}

		public var body: some View {
			Text(verbatim: text)
				.font(Self.font)
		}
	}
}

// MARK: - Constants

private extension ErrorView.ErrorTitle {
	static var font: Font { .title.weight(fontWeight) }
	static var fontWeight: Font.Weight { .semibold }
}