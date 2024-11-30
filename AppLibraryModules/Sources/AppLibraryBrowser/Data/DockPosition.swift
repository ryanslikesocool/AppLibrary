public enum DockPosition: UInt8 {
	case left
	case bottom
	case right
}

// MARK: - Equatable

extension DockPosition: Equatable { }

// MARK: - Hashable

extension DockPosition: Hashable { }
