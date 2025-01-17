import Foundation

public enum AccessibilityHelperMessageError {
	case unexpectedMessage
	case unexpectedNil
	case missingDock
	case missingDockTile(URL)
}

// MARK: - Sendable

extension AccessibilityHelperMessageError: Sendable { }

// MARK: - Error

extension AccessibilityHelperMessageError: Error { }

// MARK: - Codable

extension AccessibilityHelperMessageError: Codable { }
