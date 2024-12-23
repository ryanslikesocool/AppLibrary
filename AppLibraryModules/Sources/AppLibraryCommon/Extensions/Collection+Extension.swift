public extension Collection {
	/// - Returns: `true` if all elements in the collection are equal to each other; `false` otherwise.
	func allEqual() -> Bool where
		Element: Equatable
	{
		guard let first else {
			return true
		}

		return dropFirst().allEqual(value: first)
	}

	/// - Returns: `true` if all `transform`ed elements in the collection are equal to each other; `false` otherwise.
	func allEqual<T>(_ transform: (Element) throws -> T) rethrows -> Bool where
		T: Equatable
	{
		try self.lazy
			.map(transform)
			.allEqual()
	}
}
