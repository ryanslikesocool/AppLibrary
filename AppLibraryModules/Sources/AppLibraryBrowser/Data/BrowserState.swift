enum BrowserState {
	case loading
	case complete
	case failed(reason: BrowserError)
}

// MARK: - Sendable

extension BrowserState: Sendable { }

// MARK: - Equatable

extension BrowserState: Equatable { }

// MARK: - Hashable

extension BrowserState: Hashable { }
