import AppLibraryCommon
import AppLibraryStorage
import Foundation

enum BrowserError {
	case noSearchScopes
	case noApplications
	case allApplicationsHidden
}

// MARK: - Sendable

extension BrowserError: Sendable { }

// MARK: - Equatable

extension BrowserError: Equatable { }

// MARK: - Hashable

extension BrowserError: Hashable { }

// MARK: - Error

extension BrowserError: Error { }

// MARK: - LocalizedError

extension BrowserError: LocalizedError {
	public var errorDescription: String? {
		let localizationValue: String.LocalizationValue = switch self {
			case .noSearchScopes: "NO_SEARCH_SCOPES.DESCRIPTION"
			case .noApplications: "NO_APPLICATIONS.DESCRIPTION"
			case .allApplicationsHidden: "ALL_APPLICATIONS_HIDDEN.DESCRIPTION"
		}

		return String(localized: localizationValue, table: Self.localizationTable)
	}

	public var recoverySuggestion: String? {
		let localizationValue: String.LocalizationValue = switch self {
			case .noSearchScopes: "NO_SEARCH_SCOPES.RECOVERY_SUGGESTION"
			case .noApplications: "NO_APPLICATIONS.RECOVERY_SUGGESTION"
			case .allApplicationsHidden: "ALL_APPLICATIONS_HIDDEN.RECOVERY_SUGGESTION"
		}

		return String(localized: localizationValue, table: Self.localizationTable)
	}
}

// MARK: - Constants

private extension BrowserError {
	static let localizationTable = "BrowserError"
}

// MARK: - Supporting Data

extension BrowserError {
	public enum RecoveryAction {
		case openSettings(SettingsCategory)
		case retry
	}
}

// MARK: -

extension BrowserError {
	public var recoveryActionKind: RecoveryAction {
		switch self {
			case .noSearchScopes: .openSettings(.apps)
			case .noApplications: .openSettings(.apps)
			case .allApplicationsHidden: .openSettings(.apps)
		}
	}
}
