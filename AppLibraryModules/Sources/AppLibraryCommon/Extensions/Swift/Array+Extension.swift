public extension Array {
	// MARK: appending

	/// Returns a copy of the array with the given element appended to it.
	func appending(_ newElement: Element) -> Self {
		var result = self
		result.append(newElement)
		return result
	}

	/// Returns a copy of the array with the given elements appended to it.
	func appending(contentsOf newElements: some Sequence<Element>) -> Self {
		var result = self
		result.append(contentsOf: newElements)
		return result
	}

	// MARK: filter

	func filter<Filter>(using filter: Filter) -> [Element] where
		Filter: FilterProtocol,
		Filter.Subject == Element
	{
		filter.filter(subjects: self)
	}

	// MARK: prepend

	/// Inserts a new element at the start of the array.
	///
	/// - Complexity: O(*n*), where *n* is the length of the array.
	///
	/// - Parameter newElement: The new element to prepend into the array.
	mutating func prepend(_ newElement: Element) {
		insert(newElement, at: startIndex)
	}

	/// Inserts the given sequence at the start of the array.
	///
	/// - Complexity: O(*n* + *m*), where *n* is length of this collection and *m* is the length of `newElements`.
	///
	/// - Parameter newElements: The new elements to prepend into the array.
	mutating func prepend(contentsOf newElements: some Collection<Element>) {
		insert(contentsOf: newElements, at: startIndex)
	}

	// MARK: prepending

	/// Returns a copy of the array with the given element prepended to it.
	func prepending(_ newElement: Element) -> Self {
		var result = self
		result.prepend(newElement)
		return result
	}

	/// Returns a copy of the array with the given elements prepended to it.
	func prepending(contentsOf newElements: some Collection<Element>) -> Self {
		var result = self
		result.prepend(contentsOf: newElements)
		return result
	}
}
