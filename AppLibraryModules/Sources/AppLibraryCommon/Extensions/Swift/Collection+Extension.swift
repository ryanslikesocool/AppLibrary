import Foundation

public extension Collection {
	// MARK: allEqual

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
		try lazy
			.map(transform)
			.allEqual()
	}

	// MARK: chunked

	/// Returns a collection of subsequences of this collection, chunked by
	/// grouping elements that project to equal values.
	///
	/// - Remark: This implementation is taken from [Swift Algorithms]( https://github.com/apple/swift-algorithms ).
	///
	/// - Parameter projection: A closure that takes an element in the collection
	/// and returns an `Equatable` value that can be used to determine if adjacent
	/// elements belong in the same group.
	///
	/// - Complexity: O(*n*), where *n* is the length of this collection.
	func chunked<Subject>(
		on projection: (Element) throws -> Subject
	) rethrows -> [(subject: Subject, elements: SubSequence)] where
		Subject: Equatable
	{
		guard !isEmpty else { return [] }
		var result: [(Subject, SubSequence)] = []

		var start = startIndex
		var subject = try projection(self[start])

		for (index, element) in indexed().dropFirst() {
			let nextSubject = try projection(element)
			if subject != nextSubject {
				result.append((subject, self[start ..< index]))
				start = index
				subject = nextSubject
			}
		}

		if start != endIndex {
			result.append((subject, self[start...]))
		}

		return result
	}
}
