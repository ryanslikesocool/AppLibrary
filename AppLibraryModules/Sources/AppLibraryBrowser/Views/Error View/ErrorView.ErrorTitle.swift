import LocalizationTable
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
		let localizationTable: LocalizationTableResource = .browserError

		return switch self {
			case .noSearchScopes?: String(localized: "TITLE.NO_SEARCH_SCOPES", table: localizationTable)
			case .noApps?: String(localized: "TITLE.NO_APPS", table: localizationTable)
			case .allAppsHidden?: String(localized: "TITLE.ALL_APPS_HIDDEN", table: localizationTable)
			case .queryStartFailure?,
			     nil: String(localized: "TITLE.LOAD_FAILURE", table: localizationTable)
		}
	}
}
