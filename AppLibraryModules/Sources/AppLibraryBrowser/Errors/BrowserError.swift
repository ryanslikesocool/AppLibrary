import Foundation

enum BrowserError {
	case queryStartFailure
	case noSearchDirectories
	case noApps
	case allHidden
}

// MARK: - LocalizedError

extension BrowserError: LocalizedError {
	var errorDescription: String? {
		switch self {
			case .queryStartFailure: "Failed to start query."
			case .noSearchDirectories: "No directories to search in."
			case .noApps: "No apps could be found."
			case .allHidden: "All apps are hidden."
		}
	}

	var recoverySuggestion: String? {
		switch self {
			case .queryStartFailure: nil
			case .noSearchDirectories: "Add search directories from the settings pane."
			case .noApps: "Add more search directories from the settings pane."
			case .allHidden: "Unhide apps from the settings pane."
		}
	}
}
