public enum XPCFailure {
	case unexpectedRequest
	case requestFailed
	case invalidResponse
}

// MARK: - Sendable

extension XPCFailure: Sendable { }

// MARK: - Error

extension XPCFailure: Error { }
