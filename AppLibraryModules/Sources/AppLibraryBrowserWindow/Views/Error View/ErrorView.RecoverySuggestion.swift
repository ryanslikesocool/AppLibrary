import SwiftUI

extension ErrorView {
	struct RecoverySuggestion: View {
		private let text: String

		public init?(error: BrowserError) {
			guard let text = error.recoverySuggestion else {
				return nil
			}
			self.text = text
		}

		public var body: some View {
			Text(verbatim: text)
		}
	}
}
