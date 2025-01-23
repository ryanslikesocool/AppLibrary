enum ListViewImplementation {
	case list
	case lazyVStack
}

// MARK: - Sendable

extension ListViewImplementation: Sendable { }

// MARK: - Equatable

extension ListViewImplementation: Equatable { }