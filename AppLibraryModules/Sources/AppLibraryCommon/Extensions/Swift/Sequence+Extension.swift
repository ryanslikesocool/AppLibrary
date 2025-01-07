import Foundation

// MARK: - Functions

public extension Sequence {
	// MARK: allEqual

	/// - Returns: `true` if all elements in the sequence equal the `equalityValue`; `false` otherwise.
	func allEqual(value equalityValue: Element) -> Bool where
		Element: Equatable
	{
		allSatisfy { (element: Element) -> Bool in
			element == equalityValue
		}
	}

	/// - Returns: `true` if all elements in the sequence, after being `transform`ed, equal the `equalityValue`; `false` otherwise.
	func allEqual<T>(value equalityValue: T, _ transform: (Element) throws -> T) rethrows -> Bool where
		T: Equatable
	{
		try lazy
			.map(transform)
			.allEqual(value: equalityValue)
	}

	// MARK: sorted

	/// - Parameters:
	///   - keyPath:
	///   - order: If the resulting order is forward or reverse.
	func sorted<Value>(
		by keyPath: any KeyPath<Element, Value> & Sendable,
		order: SortOrder = .forward
	) -> [Element] where
		Value: Comparable
	{
		let comparator = KeyPathComparator(keyPath, order: order)
		return sorted(using: comparator)
	}

	/// - Parameters:
	///   - keyPath:
	///   - order: If the resulting order is forward or reverse.
	func sorted<Value>(
		by keyPath: any KeyPath<Element, Value?> & Sendable,
		order: SortOrder = .forward
	) -> [Element] where
		Value: Comparable
	{
		let comparator = KeyPathComparator(keyPath, order: order)
		return sorted(using: comparator)
	}

	/// - Parameters:
	///   - keyPath:
	///   - order: If the resulting order is forward or reverse.
	func sorted<Value, Comparator>(
		by keyPath: any KeyPath<Element, Value> & Sendable,
		comparator: Comparator,
		order: SortOrder = .forward
	) -> [Element] where
		Comparator: SortComparator,
		Comparator.Compared == Value
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator, order: order)
		return sorted(using: keyPathComparator)
	}

	/// - Parameters:
	///   - keyPath:
	///   - order: If the resulting order is forward or reverse.
	func sorted<Value, Comparator>(
		by keyPath: any KeyPath<Element, Value?> & Sendable,
		comparator: Comparator,
		order: SortOrder = .forward
	) -> [Element] where
		Comparator: SortComparator,
		Comparator.Compared == Value
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator, order: order)
		return sorted(using: keyPathComparator)
	}

	// MARK: min

	/// Returns the minimum element in the sequence, using the given comparator to compare two elements.
	/// - Returns: The sequence’s minimum element, according to `comparator`. If the sequence has no elements, returns `nil`.
	func min(
		using comparator: some SortComparator<Element>
	) -> Element? {
		self.min { (lhs: Element, rhs: Element) -> Bool in
			comparator.compare(lhs, rhs) == .orderedAscending
		}
	}

	// MARK: max

	/// Returns the maximum element in the sequence, using the given comparator to compare two elements.
	/// - Returns: The sequence’s maximum element, according to `comparator`. If the sequence has no elements, returns `nil`.
	func max(
		using comparator: some SortComparator<Element>
	) -> Element? {
		self.min { (lhs: Element, rhs: Element) -> Bool in
			comparator.compare(lhs, rhs) == .orderedAscending
		}
	}
}
