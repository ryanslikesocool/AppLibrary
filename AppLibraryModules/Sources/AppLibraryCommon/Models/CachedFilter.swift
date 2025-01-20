import Foundation

open class CachedFilter<Element, Index>: ObservableObject where
	Index: Comparable
{
	private var previousEvaluation: CachedFilterResult<Index>?

	public init() {
		previousEvaluation = nil
	}

	/// - Parameter element: The element to evaluate.
	/// - Returns: `true` if the given `element` should be included in the result; `false` otherwise.
	open func evaluate(
		_ element: Element
	) -> Bool {
		preconditionFailure("All subclasses of `CachedFilter` must override `evaluate(_:)`")
	}

	/// Evaluate the given `collection`, returning the cached result if possible.
	///
	/// - Parameter collection: The collection to evaluate.
	fileprivate func evaluate<C>(
		_ collection: C
	) -> [Element] where
		C: Collection & Hashable,
		C.Index == Index,
		C.Element == Element
	{
		if
			let previousEvaluation,
			previousEvaluation.matches(collection: collection)
		{
			return previousEvaluation.elements(in: collection)
		}

		let results: [(index: Index, element: Element)] = collection
			.indices
			.map { index in
				(index, collection[index])
			}
			.filter { _, element in
				self.evaluate(element)
			}

		previousEvaluation = CachedFilterResult(collection, resultIndices: results.map(\.index))

		return results.map(\.element)
	}
}

// MARK: - Supporting Data

private struct CachedFilterResult<Index> where
	Index: Comparable
{
	/// The `hashValue` of the evaluated collection.
	private let collectionHashValue: Int

	/// The indices of the filter results from the evaluated collection.
	public let resultIndices: [Index]

	/// - Parameters:
	///   - collection: The collection that was evaluated.
	///   - resultIndices: The indices of the filter results from the `collection`.
	public init<C>(
		_ collection: borrowing C,
		resultIndices: [Index]
	) where
		C: Collection & Hashable,
		C.Index == Index
	{
		collectionHashValue = collection.hashValue
		self.resultIndices = resultIndices
	}

	/// - Parameter collection: The collection to compare against.
	/// - Returns: `true` if the given `collection`'s `hashValue` matches this filter result; `false` otherwise.
	public func matches<C>(
		collection: borrowing C
	) -> Bool where
		C: Collection & Hashable,
		C.Index == Index
	{
		collection.hashValue == collectionHashValue
	}

	/// - Remark: This function assumes that ``matches(collection:)`` returned `true` for the given `collection`.
	///
	/// - Parameter collection: The collection to retrieve values from.
	public func elements<C>(
		in collection: C
	) -> [C.Element] where
		C: Collection & Hashable,
		C.Index == Index
	{
		resultIndices.map { index in
			collection[index]
		}
	}
}

// MARK: - Convenience

public extension Collection where
	Self: Hashable
{
	func filter(
		using cachedFilter: CachedFilter<Element, Index>
	) -> [Element] {
		cachedFilter.evaluate(self)
	}
}
