import Foundation

/// A sort comparator capable of comparing optional values.
public struct OptionalComparator<Value>: SortComparator {
	public typealias Compared = Value?

	/// The comparator used to compare two non-`nil` objects.
	private var comparator: any SortComparator<Value>

	/// Determines how to handle `nil` objects when compared against non-`nil` objects.
	public var optionalBehavior: OptionalSortBehavior

	/// If the resulting order is forward or reverse.
	public var order: SortOrder {
		get { comparator.order }
		set { comparator.order = newValue }
	}

	/// Create an optional sort comparator.
	/// 
	/// - Parameters:
	///   - comparator: The comparator used to compare two non-`nil` objects.
	///   - optionalBehavior: Determine how to handle `nil` objects when compared against non-`nil` objects.
	public init<Comparator>(
		comparator: Comparator,
		optionalBehavior: OptionalSortBehavior = .nilLast
	) where
		Comparator: SortComparator,
		Comparator.Compared == Value
	{
		self.comparator = comparator
		self.optionalBehavior = optionalBehavior
	}

	public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
		let forwardResult: ComparisonResult

		switch (lhs, rhs) {
			case let (lhs?, rhs?):
				// comparator already handles `order`, early return
				return comparator.compare(lhs, rhs)
			case (.some, .none):
				switch optionalBehavior {
					case .nilFirst: forwardResult = .orderedDescending
					case .nilLast: forwardResult = .orderedAscending
					case .same:
						// `orderedSame` inverse is identical, early return
						return .orderedSame
				}
			case (.none, .some):
				switch optionalBehavior {
					case .nilFirst: forwardResult = .orderedAscending
					case .nilLast: forwardResult = .orderedDescending
					case .same:
						// `orderedSame` inverse is identical, early return
						return .orderedSame
				}
			case (.none, .none):
				// `orderedSame` inverse is identical, early return
				return .orderedSame
		}

		return switch order {
			case .forward: forwardResult
			case .reverse: forwardResult.inverse
		}
	}
}

// MARK: - Equatable

extension OptionalComparator: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		areEqual(lhs.comparator, rhs.comparator)
			&& lhs.optionalBehavior == rhs.optionalBehavior
	}
}

// MARK: - Hashable

extension OptionalComparator: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(comparator)
		hasher.combine(optionalBehavior)
	}
}

// MARK: - Convenience

public extension OptionalComparator {
	/// - Parameters:
	///   - optionalBehavior: Determine how to handle `nil` objects when compared against non-`nil` objects.
	///   - order: If the resulting order is forward or reverse.
	init(
		optionalBehavior: OptionalSortBehavior = .nilLast,
		order: SortOrder = .forward
	) where
		Value: Comparable
	{
		self.init(
			comparator: ComparableComparator(order: order),
			optionalBehavior: optionalBehavior
		)
	}
}
