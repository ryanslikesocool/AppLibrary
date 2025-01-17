import OSLog

public extension Logger {
	/// Creates a logger using the default subsystem and specified category.
	///
	/// - Parameter category: The string that the system uses to categorize emitted signposts.
	init(category: String) {
		self.init(subsystem: Self.subsystem, category: category)
	}

	/// Creates a logger using the default subsystem and specified category.
	///
	/// - Parameter category: The type that the system uses to categorize emitted signposts.
	init(category: Any.Type) {
		self.init(category: String(describing: category))
	}
}

// MARK: - Constants

private extension Logger {
	static let subsystem: String = Bundle.main.bundleIdentifier!
}
