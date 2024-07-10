import OSLog

package extension Logger {
	private static let subsystem: String = Bundle.main.bundleIdentifier!

	init(category: String) {
		self.init(subsystem: Self.subsystem, category: category)
	}
}
