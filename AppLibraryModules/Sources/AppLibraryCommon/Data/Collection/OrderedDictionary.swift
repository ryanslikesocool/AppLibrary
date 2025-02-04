import CollectionToolbox
import Foundation

// TODO: Consider using `OrderedDictionary` from Swift Collections.
// https://github.com/apple/swift-collections

public struct OrderedDictionary<Key, Value> where
	Key: Hashable
{
	public typealias Storage = [Key: Value]
	public typealias Order = [Key]

	private var storage: Storage

	/// The order of the IDs in ``storage``.
	private var order: Order

	private init(
		storage: Storage,
		order: Order
	) {
		self.storage = storage
		self.order = order
	}

	public init() {
		self.init(
			storage: [:],
			order: []
		)
	}

	/// Creates an empty dictionary with preallocated space for at least the specified number of elements.
	///
	/// Use this initializer to avoid intermediate reallocations of a dictionary’s storage buffer when you know how many key-value pairs you are adding to a dictionary after creation.
	///
	/// - Parameter minimumCapacity: The minimum number of key-value pairs that the newly created dictionary should be able to store without reallocating its storage buffer.
	public init(minimumCapacity: Int) {
		self.init(
			storage: Storage(minimumCapacity: minimumCapacity),
			order: Order(minimumCapacity: minimumCapacity)
		)
	}

	/// Creates a new dictionary from the key-value pairs in the given sequence, using a combining closure to determine the value for any duplicate keys.
	///
	/// You use this initializer to create a dictionary when you have a sequence of key-value tuples that might have duplicate keys.
	/// As the dictionary is built, the initializer calls the combine closure with the current and new values for any duplicate keys.
	/// Pass a closure as combine that returns the value to use in the resulting dictionary:
	/// The closure can choose between the two values, combine them to produce a new value, or even throw an error.
	///
	/// - Parameters:
	///   - keysAndValues: A sequence of key-value pairs to use for the new dictionary.
	///   - combine: A closure that is called with the values for any duplicate keys that are encountered. The closure returns the desired value for the final dictionary.
	public init<S>(_ keysAndValues: S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows where
		S: Sequence,
		S.Element == (Key, Value)
	{
		try self.init(
			storage: Storage(keysAndValues, uniquingKeysWith: combine),
			// There's gotta be a better way to do this...
			order: keysAndValues.reduce(into: Order()) { partialResult, element in
				if !partialResult.contains(element.0) {
					partialResult.append(element.0)
				}
			}
		)
	}

	/// Creates a new dictionary from the key-value pairs in the given sequence.
	///
	/// - Precondition: The sequence must not have duplicate keys.
	///
	/// - Parameter keysAndValues: A sequence of key-value pairs to use for the new dictionary.
	/// Every key in `keysAndValues` must be unique.
	public init<S>(uniqueKeysWithValues keysAndValues: S) where
		S: Sequence,
		S.Element == (Key, Value)
	{
		self.init(
			storage: Storage(uniqueKeysWithValues: keysAndValues),
			order: keysAndValues.map(\.0)
		)
	}

	/// Creates a new dictionary whose keys are the groupings returned by the given closure and whose values are arrays of the elements that returned each key.
	///
	/// The arrays in the “values” position of the new dictionary each contain at least one element, with the elements in the same order as the source sequence.
	///
	/// - Parameters:
	///   - values: A sequence of values to group into a dictionary.
	///   - keyForValue: A closure that returns a key for each element in `values`.
	public init<S>(grouping values: S, by keyForValue: (S.Element) throws -> Key) rethrows where
		S: Sequence,
		Value == [S.Element]
	{
		try self.init(
			storage: Storage(grouping: values, by: keyForValue),
			// There's gotta be a better way to do this...
			order: values.reduce(into: Order()) { partialResult, element in
				let key = try keyForValue(element)
				if !partialResult.contains(key) {
					partialResult.append(key)
				}
			}
		)
	}

	public init<S>(_ elements: borrowing S) where
		S: Sequence,
		S.Element == Value,
		Value: Identifiable,
		Value.ID == Key
	{
		self.init(elements.map { element in (element.id, element) }) { _, newValue in
			newValue
		}
	}
}

// MARK: - Sendable

extension OrderedDictionary: Sendable where Key: Sendable, Value: Sendable { }

// MARK: - Equatable

extension OrderedDictionary: Equatable where Value: Equatable { }

// MARK: - Hashable

extension OrderedDictionary: Hashable where Value: Hashable { }

// MARK: - Encodable

// extension OrderedDictionary: Encodable where Key: Encodable, Value: Encodable {
// TODO: Implement Encodable
// }

// MARK: - Decodable

// extension OrderedDictionary: Decodable where Key: Decodable, Value: Decodable {
// TODO: Implement Decodable
// }

// MARK: - Sequence

extension OrderedDictionary: Sequence {
	public typealias Element = Value

	public func makeIterator() -> Iterator {
		Iterator(self)
	}
}

// MARK: - Collection

extension OrderedDictionary: Collection {
	public typealias Index = Order.Index

	public var startIndex: Index { order.startIndex }

	public var endIndex: Index { order.endIndex }

	public subscript(position: Index) -> Element {
		// VALIDATE: Is it okay to unsafely unwrap this value?
		storage[order[position]]!
	}
}

// MARK: - BidirectionalCollection

extension OrderedDictionary: BidirectionalCollection { }

// MARK: - RandomAccessCollection

extension OrderedDictionary: RandomAccessCollection { }

// MARK: - ExpressibleByDictionaryLiteral

extension OrderedDictionary: ExpressibleByDictionaryLiteral {
	public init(dictionaryLiteral elements: (Key, Value)...) {
		self.init(uniqueKeysWithValues: elements)
	}
}

// MARK: - Iterator

public extension OrderedDictionary {
	// VALIDATE: Is this iterator approach actually more efficient
	// compared to pre-computing with `OrderedDictionary.values`?
	struct Iterator: IteratorProtocol {
//		private typealias Storage = OrderedDictionary.Storage
//		private typealias Order = OrderedDictionary.Order
		public typealias Element = OrderedDictionary.Element

		private let storage: Storage
		private var orderIterator: Order.Iterator

		public init(_ orderedDictionary: OrderedDictionary) {
			storage = orderedDictionary.storage
			orderIterator = orderedDictionary.order.makeIterator()
		}

		public mutating func next() -> Element? {
			guard let id = orderIterator.next() else {
				return nil
			}

			// VALIDATE: Is it okay to unsafely unwrap this value?
			return storage[id]!
		}
	}
}

// MARK: - Properties

public extension OrderedDictionary {
	var keys: [Key] {
		order
	}

	var values: [Value] {
		order.map { key in
			storage[key]!
		}
	}
}

// MARK: - Sort

public extension OrderedDictionary {
	mutating func sort(
		by areInIncreasingOrder: (Element, Element) -> Bool
	) {
		order = storage.sorted { lhs, rhs in
			areInIncreasingOrder(lhs.value, rhs.value)
		}
		.map(\.key)
	}

	mutating func sort<Comparator>(
		using comparator: Comparator
	) where
		Comparator: SortComparator,
		Comparator.Compared == Element
	{
		let pairComparator = KeyPathComparator(\Storage.Element.value, comparator: comparator)
		order = storage.sorted(using: pairComparator).map(\.key)
	}

	mutating func sort<Compared>(
		by keyPath: any KeyPath<Element, Compared> & Sendable
	) where
		Compared: Comparable
	{
		let keyPathComparator = KeyPathComparator(keyPath)
		sort(using: keyPathComparator)
	}

	mutating func sort<Compared>(
		by keyPath: any KeyPath<Element, Compared?> & Sendable
	) where
		Compared: Comparable
	{
		let keyPathComparator = KeyPathComparator(keyPath)
		sort(using: keyPathComparator)
	}

	mutating func sort<Compared, Comparator>(
		by keyPath: any KeyPath<Element, Compared> & Sendable,
		comparator: Comparator
	) where
		Comparator: SortComparator,
		Comparator.Compared == Compared
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
		sort(using: keyPathComparator)
	}

	mutating func sort<Compared, Comparator>(
		by keyPath: any KeyPath<Element, Compared?> & Sendable,
		comparator: Comparator
	) where
		Comparator: SortComparator,
		Comparator.Compared == Compared
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
		sort(using: keyPathComparator)
	}
}

// MARK: - Sorted

public extension OrderedDictionary {
	func sorted(
		by areInIncreasingOrder: (Element, Element) -> Bool
	) -> Self {
		Self(
			storage: storage,
			order: storage.sorted { lhs, rhs in
				areInIncreasingOrder(lhs.value, rhs.value)
			}
			.map(\.key)
		)
	}

	func sorted<Comparator>(
		using comparator: Comparator
	) -> Self where
		Comparator: SortComparator,
		Comparator.Compared == Element
	{
		let pairComparator = KeyPathComparator(\Storage.Element.value, comparator: comparator)
		return Self(
			storage: storage,
			order: storage.sorted(using: pairComparator).map(\.key)
		)
	}

	func sorted<Compared>(
		by keyPath: any KeyPath<Element, Compared> & Sendable
	) -> Self where
		Compared: Comparable
	{
		let keyPathComparator = KeyPathComparator(keyPath)
		return sorted(using: keyPathComparator)
	}

	func sorted<Compared>(
		by keyPath: any KeyPath<Element, Compared?> & Sendable
	) -> Self where
		Compared: Comparable
	{
		let keyPathComparator = KeyPathComparator(keyPath)
		return sorted(using: keyPathComparator)
	}

	func sorted<Compared, Comparator>(
		by keyPath: any KeyPath<Element, Compared> & Sendable,
		comparator: Comparator
	) -> Self where
		Comparator: SortComparator,
		Comparator.Compared == Compared
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
		return sorted(using: keyPathComparator)
	}

	func sorted<Compared, Comparator>(
		by keyPath: any KeyPath<Element, Compared?> & Sendable,
		comparator: Comparator
	) -> Self where
		Comparator: SortComparator,
		Comparator.Compared == Compared
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
		return sorted(using: keyPathComparator)
	}
}

// MARK: - Subscript

public extension OrderedDictionary {
	subscript(key: Key) -> Value? {
		get { storage[key] }
		set { storage[key] = newValue }
	}

	subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
		get { storage[key, default: defaultValue()] }
		set { storage[key, default: defaultValue()] = newValue }
	}
}

// MARK: -

public extension OrderedDictionary {
	@discardableResult
	mutating func removeValue(forKey key: Key) -> Value? {
		guard let result = storage.removeValue(forKey: key) else {
			return nil
		}
		order.removeAll(where: { key in key == key })
		return result
	}

	/// Exchanges the values at the specified indices of the collection.
	///
	/// Both parameters must be valid indices of the collection that are not equal to `endIndex`.
	/// Calling `swapAt(_:_:)` with the same index as both `i` and `j` has no effect.
	///
	/// - Complexity: O(1)
	///
	/// - Parameters:
	///   - i: The index of the first value to swap.
	///   - j: The index of the second value to swap.
	mutating func swapAt(_ i: Index, _ j: Index) {
		order.swapAt(i, j)
	}

	/// Updates the value stored in the dictionary for the given key, or adds a new key-value pair if the key does not exist.
	///
	/// Use this method instead of key-based subscripting when you need to know whether the new value supplants the value of an existing key.
	/// If the value of an existing key is updated, `updateValue(_:forKey:)` returns the original value.
	///
	/// - Parameters:
	///   - value: The new value to add to the dictionary.
	///   - key: The key to associate with `value`.
	///   If `key` already exists in the dictionary, `value` replaces the existing associated value.
	///   If `key` isn’t already a key of the dictionary, the `(key, value)` pair is added.
	/// - Returns: The value that was replaced, or `nil` if a new key-value pair was added.
	@discardableResult
	mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
		let result = storage.updateValue(value, forKey: key)

		if result == nil {
			order.append(key)
		}

		return result
	}

	/// Merges the key-value pairs in the given sequence into the dictionary, using a combining closure to determine the value for any duplicate keys.
	///
	/// Use the `combine` closure to select a value to use in the updated dictionary, or to combine existing and new values.
	/// As the key-value pairs are merged with the dictionary, the `combine` closure is called with the current and new values for any duplicate keys that are encountered.
	///
	/// - Parameters:
	///   - other: A sequence of key-value pairs.
	///   - combine: A closure that takes the current and new values for any duplicate keys. The closure returns the desired value for the final dictionary.
	mutating func merge<S>(_ other: S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows where
		S: Sequence,
		S.Element == (Key, Value)
	{
		try storage.merge(other, uniquingKeysWith: combine)
		order.append(contentsOf: other.map(\.0).filter { key in
			!order.contains(key)
		})
	}

	/// Merges the key-value pairs in the given sequence into the dictionary, using a combining closure to determine the value for any duplicate keys.
	///
	/// Use the `combine` closure to select a value to use in the updated dictionary, or to combine existing and new values.
	/// As the key-value pairs are merged with the dictionary, the `combine` closure is called with the current and new values for any duplicate keys that are encountered.
	///
	/// - Parameters:
	///   - other: A sequence of key-value pairs.
	///   - combine: A closure that takes the current and new values for any duplicate keys. The closure returns the desired value for the final dictionary.
	mutating func merge(_ other: Self, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows {
		try merge(other.storage.map { key, value in (key, value) }, uniquingKeysWith: combine)
	}

	/// - Parameter key: The key of the value to access.
	/// - Returns: The value for the given `key`, if it could be found; `nil` otherwise.
	func value(for key: Key) -> Value? {
		self[key]
	}

	/// - Parameter keys: The keys of the values to access.
	/// - Returns: In order, for each element: the value for the key, if it could be found; `nil` otherwise.
	func values(
		for keys: borrowing some Sequence<Key>
	) -> [Value?] {
		keys.map(value(for:))
	}
}
