// MARK: - Convenience

public extension Array {
	/// Creates an empty array with preallocated space for at least the specified number of elements.
	///
	/// Use this initializer to avoid intermediate reallocations of an array's storage buffer when you know how many elements you are adding to an array after creation.
	///
	/// - Parameter minimumCapacity: The minimum number of elements that the newly created array should be able to store without reallocating its storage buffer.
	init(minimumCapacity: Int) {
		self.init()
		reserveCapacity(minimumCapacity)
	}
}
