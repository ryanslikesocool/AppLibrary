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
			Text(text)
				.font(.title)
				.fontWeight(.semibold)
		}
	}
}
