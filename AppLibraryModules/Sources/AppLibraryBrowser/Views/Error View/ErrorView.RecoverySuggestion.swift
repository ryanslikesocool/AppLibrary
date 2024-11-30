import LocalizationTable
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
		lazy var localizationTable: LocalizationTableResource = .browserError

		return switch self {
			case .noSearchScopes?: String(localized: "RECOVERY_SUGGESTION.NO_SEARCH_SCOPES", table: localizationTable)
			case .noApps?: String(localized: "RECOVERY_SUGGESTION.NO_APPS", table: localizationTable)
			case .allAppsHidden?: String(localized: "RECOVERY_SUGGESTION.ALL_APPS_HIDDEN", table: localizationTable)
			case .queryStartFailure?,
			     nil: nil
		}
	}
}
