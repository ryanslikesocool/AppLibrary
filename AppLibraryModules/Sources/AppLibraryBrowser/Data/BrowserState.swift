enum BrowserState {
	case loading(MetadataQuery)
	case complete
	case failed(reason: BrowserError)
}

// MARK: - Equatable

extension BrowserState: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		switch (lhs, rhs) {
			case let (.loading(lhs), .loading(rhs)): lhs === rhs
			case (.complete, .complete): true
			case let (.failed(lhs), .failed(rhs)): lhs == rhs
			default: false
		}
	}
}

// MARK: - Hashable

//extension BrowserState: Hashable { }
