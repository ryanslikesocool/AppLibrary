/// Constants that indicate what edge of the screen the system dock lies on.
public enum DockEdge: UInt8 {
	/// The left edge of the screen.
	case left

	/// The bottom edge of the screen.
	case bottom

	/// The right edge of the screen.
	case right
}

// MARK: - Sendable

extension DockEdge: Sendable { }

// MARK: - Equatable

extension DockEdge: Equatable { }

// MARK: - Hashable

extension DockEdge: Hashable { }
