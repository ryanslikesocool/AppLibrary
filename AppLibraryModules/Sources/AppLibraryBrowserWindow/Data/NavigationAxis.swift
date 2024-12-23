enum NavigationAxis: UInt8 {
	case horizontal
	case vertical
}

// MARK: - Sendable

extension NavigationAxis: Sendable { }

// MARK: - Equatable

extension NavigationAxis: Equatable { }

// MARK: - Hashable

extension NavigationAxis: Hashable { }

// MARK: -

extension NavigationAxis {
	var perpendicular: Self {
		Self(rawValue: 1 - rawValue).unsafelyUnwrapped
	}
}
