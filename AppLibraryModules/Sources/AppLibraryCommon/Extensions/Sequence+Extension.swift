import Foundation

public extension Sequence {
	func sorted<T>(
		by keyPath: any KeyPath<Element, T> & Sendable,
		order: SortOrder = .forward
	) -> [Element] where
		T: Comparable
	{
		let comparator = KeyPathComparator(keyPath, order: order)
		return sorted(using: comparator)
	}
}