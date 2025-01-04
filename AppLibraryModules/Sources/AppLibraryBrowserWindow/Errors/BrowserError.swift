import AppLibraryCommon
import AppLibraryResources
import AppLibraryStorage
import Foundation

enum BrowserError: Swift.Error {
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

// MARK: - LocalizedError

extension BrowserError: LocalizedError {
	var errorDescription: String? {
		let localizedStringResource: LocalizedStringResource = switch self {
			case .noSearchScopes: .browserError.noSearchScopes.description
			case .noApplications: .browserError.noApplications.description
			case .allApplicationsHidden: .browserError.allApplicationsHidden.description
		}

		return String(localized: localizedStringResource)
	}

	var recoverySuggestion: String? {
		let localizedStringResource: LocalizedStringResource = switch self {
			case .noSearchScopes: .browserError.noSearchScopes.recoverySuggestion
			case .noApplications: .browserError.noApplications.recoverySuggestion
			case .allApplicationsHidden: .browserError.allApplicationsHidden.recoverySuggestion
		}

		return String(localized: localizedStringResource)
	}
}

// MARK: - Supporting Data

extension BrowserError {
	enum RecoveryAction {
		case openSettings(SettingsCategory)
		case retry
	}
}

// MARK: -

extension BrowserError {
	var recoveryActionKind: RecoveryAction {
		switch self {
			case .noSearchScopes: .openSettings(.apps)
			case .noApplications: .openSettings(.apps)
			case .allApplicationsHidden: .openSettings(.apps)
		}
	}
}
