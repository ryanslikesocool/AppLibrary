public enum DockPosition: UInt8 {
	case left
	case bottom
	case right
}

// MARK: - Hashable

extension DockPosition: Hashable { }
