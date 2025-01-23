public enum WindowVisibilityMessage {
	case reveal
	case dismiss
}

// MARK: - Sendable

extension WindowVisibilityMessage: Sendable { }

// MARK: - Equatable

extension WindowVisibilityMessage: Equatable { }

// MARK: - Hashable

extension WindowVisibilityMessage: Hashable { }