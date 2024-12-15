import Foundation
import LocalizationTable

enum BrowserError: Swift.Error {
	case noSearchScopes
	case noApps
	case allAppsHidden
	case queryFailure(String)
}

// MARK: - Equatable

extension BrowserError: Equatable { }

// MARK: - Hashable

extension BrowserError: Hashable { }

// MARK: - LocalizedError

extension BrowserError: LocalizedError {
	var errorDescription: String? {
		let localizationKey: String.LocalizationValue = switch self {
			case .noSearchScopes: "TITLE.NO_SEARCH_SCOPES"
			case .noApps: "TITLE.NO_APPS"
			case .allAppsHidden: "TITLE.ALL_APPS_HIDDEN"
			case .queryFailure: "TITLE.LOAD_FAILURE"
		}

		return String(localized: localizationKey, table: .browserError)
	}

	var recoverySuggestion: String? {
		let localizationKey: String.LocalizationValue? = switch self {
			case .noSearchScopes: "RECOVERY_SUGGESTION.NO_SEARCH_SCOPES"
			case .noApps: "RECOVERY_SUGGESTION.NO_APPS"
			case .allAppsHidden: "RECOVERY_SUGGESTION.ALL_APPS_HIDDEN"
			case .queryFailure: nil
		}

		return if let localizationKey {
			String(localized: localizationKey, table: .browserError)
		} else {
			nil
		}
	}
}

// MARK: - Constants

private extension LocalizationTableResource {
	static let browserError = Self("BrowserError")
}

// MARK: -

extension BrowserError {
	static func queryFailure(_ error: any Error) -> Self {
		.queryFailure(String(describing: error))
	}
}