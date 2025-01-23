/// Constants that define how a view might be implemented.
public enum ViewImplementation {
	/// Specifies that a view should use an AppKit implementation.
	case appKit

	/// Specifies that a view should use a SwiftUI implementation.
	case swiftUI
}

// MARK: - Sendable

extension ViewImplementation: Sendable { }

// MARK: - Equatable

extension ViewImplementation: Equatable { }

// MARK: - Hashable

extension ViewImplementation: Hashable { }