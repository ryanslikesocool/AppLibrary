//import AppLibraryCommon
//import Foundation
//
//public extension ApplicationModelIdentifier {
//	@MainActor
//	struct ApplicationComparator {
//		public typealias Compared = ApplicationModelIdentifier
//
//		private var innerComparator: OptionalComparator<Application>
//
//		public init<Comparator>(
//			comparator: Comparator,
//			optionalBehavior: OptionalSortBehavior = .nilLast
//		) where
//			Comparator: SortComparator,
//			Comparator.Compared == Application
//		{
//			innerComparator = OptionalComparator(comparator: comparator, optionalBehavior: optionalBehavior)
//		}
//	}
//}
//
//// MARK: - Sendable
//
//extension ApplicationModelIdentifier.ApplicationComparator: Sendable { }
//
//// MARK: - Equatable
//
//extension ApplicationModelIdentifier.ApplicationComparator: @preconcurrency Equatable {
//	public static func == (lhs: Self, rhs: Self) -> Bool {
//		lhs.innerComparator == rhs.innerComparator
//	}
//}
//
//// MARK: - Hashable
//
//extension ApplicationModelIdentifier.ApplicationComparator: @preconcurrency Hashable {
//	public func hash(into hasher: inout Hasher) {
//		hasher.combine(innerComparator)
//	}
//}
//
//// MARK: - SortComparator
//
//extension ApplicationModelIdentifier.ApplicationComparator: @preconcurrency SortComparator {
//	public var order: SortOrder {
//		get { innerComparator.order }
//		set { innerComparator.order = newValue }
//	}
//
//	public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
//		let applicationCache = ApplicationCache.shared
//
//		return innerComparator.compare(
//			applicationCache.applications[lhs],
//			applicationCache.applications[rhs]
//		)
//	}
//}
//
//// MARK: - Convenience
//
//@MainActor
//public extension SortComparator where
//	Self == ApplicationModelIdentifier.ApplicationComparator
//{
//	static func application<Comparator>(
//		comparator: Comparator,
//		optionalBehavior: OptionalSortBehavior = .nilLast
//	) -> Self where
//		Comparator: SortComparator,
//		Comparator.Compared == Application
//	{
//		Self(comparator: comparator, optionalBehavior: optionalBehavior)
//	}
//
//	static func application<T>(
//		by keyPath: any KeyPath<Application, T> & Sendable,
//		order: SortOrder = .forward,
//		optionalBehavior: OptionalSortBehavior = .nilLast
//	) -> Self where
//		T: Comparable
//	{
//		let comparator = KeyPathComparator(keyPath, order: order)
//		return Self(comparator: comparator, optionalBehavior: optionalBehavior)
//	}
//
//	static func application<T>(
//		by keyPath: any KeyPath<Application, T?> & Sendable,
//		order: SortOrder = .forward,
//		optionalBehavior: OptionalSortBehavior = .nilLast
//	) -> Self where
//		T: Comparable
//	{
//		let comparator = KeyPathComparator(keyPath, order: order)
//		return Self(comparator: comparator, optionalBehavior: optionalBehavior)
//	}
//
//	static func application<T, Comparator>(
//		by keyPath: any KeyPath<Application, T> & Sendable,
//		comparator: Comparator,
//		optionalBehavior: OptionalSortBehavior = .nilLast
//	) -> Self where
//		Comparator: SortComparator,
//		Comparator.Compared == T
//	{
//		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
//		return Self(comparator: keyPathComparator, optionalBehavior: optionalBehavior)
//	}
//
//	static func application<T, Comparator>(
//		by keyPath: any KeyPath<Application, T?> & Sendable,
//		comparator: Comparator,
//		optionalBehavior: OptionalSortBehavior = .nilLast
//	) -> Self where
//		Comparator: SortComparator,
//		Comparator.Compared == T
//	{
//		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
//		return Self(comparator: keyPathComparator, optionalBehavior: optionalBehavior)
//	}
//}
