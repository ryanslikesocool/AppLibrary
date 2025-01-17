public enum DockHelperMessageError {
	case unexpectedNil
}

// MARK: - Sendable

extension DockHelperMessageError: Sendable { }

// MARK: - Error

extension DockHelperMessageError: Error { }