import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension ErrorView {
	struct RecoveryAction: View {
		private let error: BrowserError?

		public init(error: BrowserError?) {
			self.error = error
		}

		public var body: some View {
			switch error.recoverySuggestionKind {
				case let .settings(category):
					SettingsButton(destination: category) {
						Label("Settings...", systemImage: Constant.Symbol.gear)
					}
					.controlSize(.large)
				case .retry:
					RefreshAppsButton {
						Label("Retry", systemImage: Constant.Symbol.arrow_clockwise)
					}
			}
		}
	}
}

// MARK: -

private extension BrowserError? {
	enum RecoverySuggestionKind {
		case settings(SettingsCategory)
		case retry
	}

	var recoverySuggestionKind: RecoverySuggestionKind {
		switch self {
			case .queryStartFailure?: .retry
			case .noSearchScopes?: .settings(.location)
			case .noApps?: .settings(.location)
			case .allHidden?: .settings(.apps)
			case nil: .retry
		}
	}
}
