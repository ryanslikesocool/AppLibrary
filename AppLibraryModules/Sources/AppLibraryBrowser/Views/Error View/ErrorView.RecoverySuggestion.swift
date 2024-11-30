import SwiftUI

extension ErrorView {
	struct RecoverySuggestion: View {
		private let text: String

		public init?(error: BrowserError?) {
			guard let text = error.recoverySuggestion else {
				return nil
			}
			self.text = text
		}

		public var body: some View {
			Text(text)
		}
	}
}

// MARK: -

private extension BrowserError? {
	var recoverySuggestion: String? {
		switch self {
			case .queryStartFailure?: nil
			case .noSearchScopes?: "Add search scopes in the settings pane."
			case .noApps?: "Add more search scopes in the settings pane."
			case .allHidden?: "Reveal apps in the settings pane."
			case nil: nil
		}
	}
}
