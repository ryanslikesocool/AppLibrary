import SwiftUI

extension ErrorView {
	struct ErrorTitle: View {
		private let text: String

		public init(error: BrowserError?) {
			text = error.errorTitle
		}

		public var body: some View {
			Text(text)
				.font(.title)
				.fontWeight(.semibold)
		}
	}
}

// MARK: -

private extension BrowserError? {
	var errorTitle: String {
		switch self {
			case .noSearchScopes?: "No Search Scopes"
			case .noApps?: "No Apps"
			case .allHidden?: "All Apps Hidden"
			case .queryStartFailure?,
			     nil: "Failed to Load Apps"
		}
	}
}
