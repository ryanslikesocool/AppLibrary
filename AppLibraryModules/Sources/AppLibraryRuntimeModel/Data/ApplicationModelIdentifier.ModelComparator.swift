import AppLibraryCommon
import AppLibraryStorage
import Foundation

public extension ApplicationModelIdentifier {
	@MainActor
	struct ModelComparator {
		public typealias Compared = ApplicationModelIdentifier

		private var innerComparator: OptionalComparator<ApplicationModel>

		public init<Comparator>(
			comparator: Comparator,
			optionalBehavior: OptionalSortBehavior = .nilLast
		) where
			Comparator: SortComparator,
			Comparator.Compared == ApplicationModel
		{
			innerComparator = OptionalComparator(comparator: comparator, optionalBehavior: optionalBehavior)
		}
	}
}

// MARK: - Sendable

extension ApplicationModelIdentifier.ModelComparator: Sendable { }

// MARK: - Equatable

extension ApplicationModelIdentifier.ModelComparator: @preconcurrency Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.innerComparator == rhs.innerComparator
	}
}

// MARK: - Hashable

extension ApplicationModelIdentifier.ModelComparator: @preconcurrency Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(innerComparator)
	}
}

// MARK: - SortComparator

extension ApplicationModelIdentifier.ModelComparator: @preconcurrency SortComparator {
	public var order: SortOrder {
		get { innerComparator.order }
		set { innerComparator.order = newValue }
	}

	public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
		let applicationCache = ApplicationCache.shared

		return innerComparator.compare(
			applicationCache.applications[lhs],
			applicationCache.applications[rhs]
		)
	}
}

// MARK: - Convenience

@MainActor
public extension SortComparator where
	Self == ApplicationModelIdentifier.ModelComparator
{
	static func model<Comparator>(
		comparator: Comparator,
		optionalBehavior: OptionalSortBehavior = .nilLast
	) -> Self where
		Comparator: SortComparator,
		Comparator.Compared == ApplicationModel
	{
		Self(comparator: comparator, optionalBehavior: optionalBehavior)
	}

	static func model<T>(
		by keyPath: any KeyPath<ApplicationModel, T> & Sendable,
		order: SortOrder = .forward,
		optionalBehavior: OptionalSortBehavior = .nilLast
	) -> Self where
		T: Comparable
	{
		let comparator = KeyPathComparator(keyPath, order: order)
		return Self(comparator: comparator, optionalBehavior: optionalBehavior)
	}

	static func model<T>(
		by keyPath: any KeyPath<ApplicationModel, T?> & Sendable,
		order: SortOrder = .forward,
		optionalBehavior: OptionalSortBehavior = .nilLast
	) -> Self where
		T: Comparable
	{
		let comparator = KeyPathComparator(keyPath, order: order)
		return Self(comparator: comparator, optionalBehavior: optionalBehavior)
	}

	static func model<T, Comparator>(
		by keyPath: any KeyPath<ApplicationModel, T> & Sendable,
		comparator: Comparator,
		optionalBehavior: OptionalSortBehavior = .nilLast
	) -> Self where
		Comparator: SortComparator,
		Comparator.Compared == T
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
		return Self(comparator: keyPathComparator, optionalBehavior: optionalBehavior)
	}

	static func model<T, Comparator>(
		by keyPath: any KeyPath<ApplicationModel, T?> & Sendable,
		comparator: Comparator,
		optionalBehavior: OptionalSortBehavior = .nilLast
	) -> Self where
		Comparator: SortComparator,
		Comparator.Compared == T
	{
		let keyPathComparator = KeyPathComparator(keyPath, comparator: comparator)
		return Self(comparator: keyPathComparator, optionalBehavior: optionalBehavior)
	}
}
