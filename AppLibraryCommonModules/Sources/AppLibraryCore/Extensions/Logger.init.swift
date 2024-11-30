import OSLog

public extension Logger {
	init(category: String) {
		self.init(subsystem: Self.subsystem, category: category)
	}

	init(category: Any.Type) {
		self.init(category: String(describing: category))
	}
}

// MARK: - Constants

private extension Logger {
	static let subsystem: String = Bundle.main.bundleIdentifier!
}
