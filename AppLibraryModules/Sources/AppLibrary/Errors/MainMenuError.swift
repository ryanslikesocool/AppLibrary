enum MainMenuError {
	case missingSubmenu(title: String)
}

// MARK: - Sendable

extension MainMenuError: Sendable { }

// MARK: - Error

extension MainMenuError: Error { }