import Foundation

enum BrowserError {
	case queryStartFailure
	case noSearchScopes
	case noApps
	case allHidden
}

// MARK: - LocalizedError

extension BrowserError: LocalizedError {
	var errorDescription: String? {
		switch self {
			case .queryStartFailure: "Failed to start query."
			case .noSearchScopes: "No scopes to search in."
			case .noApps: "No apps could be found."
			case .allHidden: "All apps are hidden."
		}
	}

	var recoverySuggestion: String? {
		switch self {
			case .queryStartFailure: nil
			case .noSearchScopes: "Add search scopes from the settings pane."
			case .noApps: "Add more search scopes from the settings pane."
			case .allHidden: "Unhide apps from the settings pane."
		}
	}
}
