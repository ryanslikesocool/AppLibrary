import Foundation

public extension ComparisonResult {
	/// The inverse of the comparison result.
	///
	/// | Value | Inverse |
	/// | - | - |
	/// | ``orderedAscending`` | ``orderedDescending`` |
	/// | ``orderedDescending`` | ``orderedAscending`` |
	/// | ``orderedSame`` | ``orderedSame`` |
	var inverse: Self {
		// The raw value for `ComparisonResult` works out nicely so
		// `inverse.rawValue == rawValue * -1`
		// which is idential to `-rawValue`
		Self(rawValue: rawValue).unsafelyUnwrapped

		// the above operation basically does this
//		switch self {
//			case .orderedAscending: .orderedDescending
//			case .orderedDescending: .orderedAscending
//			case .orderedSame: .orderedSame
//		}
	}

	/// Create a comparison from two [`Comparable`](https://developer.apple.com/documentation/swift/comparable) elements,
	/// using the standard less than and greater than operators.
	///
	/// | Comparison | Sort Order | Result |
	/// | - | - | - |
	/// | `lhs < rhs` | [`forward`](https://developer.apple.com/documentation/foundation/sortorder/forward) | [`orderedAscending`](https://developer.apple.com/documentation/foundation/comparisonresult/orderedascending) |
	/// | `lhs < rhs` | [`reverse`](https://developer.apple.com/documentation/foundation/sortorder/reverse) | [`orderedDescending`](https://developer.apple.com/documentation/foundation/comparisonresult/ordereddescending) |
	/// | `lhs > rhs` | [`forward`](https://developer.apple.com/documentation/foundation/sortorder/forward) | [`orderedDescending`](https://developer.apple.com/documentation/foundation/comparisonresult/ordereddescending) |
	/// | `lhs > rhs` | [`reverse`](https://developer.apple.com/documentation/foundation/sortorder/reverse) | [`orderedAscending`](https://developer.apple.com/documentation/foundation/comparisonresult/orderedascending) |
	///
	/// Any other combinations will result in [`orderedSame`](https://developer.apple.com/documentation/foundation/comparisonresult/orderedsame)\.
	///
	/// - Parameters:
	///   - lhs: The left side of the operation.
	///   - rhs: The right side of the operation.
	///   - sortOrder: If the resulting order is forward or reverse.
	init<Compared>(_ lhs: Compared, _ rhs: Compared, sortOrder: SortOrder = .forward) where
		Compared: Comparable
	{
		self = if lhs < rhs {
			switch sortOrder {
				case .forward: .orderedAscending
				case .reverse: .orderedDescending
			}
		} else if lhs > rhs {
			switch sortOrder {
				case .forward: .orderedDescending
				case .reverse: .orderedAscending
			}
		} else {
			.orderedSame
		}

		// The original implementation uses a `switch` with all three function arguments.
		// It's more compact and readable, but I'm not sure about the performance
		// implications of `case let`.
//		self = switch (lhs, rhs, sortOrder) {
//			case let (lhs, rhs, .forward) where lhs < rhs: .orderedAscending
//			case let (lhs, rhs, .reverse) where lhs < rhs: .orderedDescending
//			case let (lhs, rhs, .forward) where lhs > rhs: .orderedDescending
//			case let (lhs, rhs, .reverse) where lhs > rhs: .orderedAscending
//			default: .orderedSame
//		}

		// Another alternative is to discard the arguments.
		// This compiles but functionality is untested.
		// I'm also not sure about performance implications.
//		self = switch (lhs, rhs, sortOrder) {
//			case (_, _, .forward) where lhs < rhs: .orderedAscending
//			case (_, _, .reverse) where lhs < rhs: .orderedDescending
//			case (_, _, .forward) where lhs > rhs: .orderedDescending
//			case (_, _, .reverse) where lhs > rhs: .orderedAscending
//			default: .orderedSame
//		}

		// If `SortOrder` had an integer raw value, we could do something like this:
//		let forwardResult: ComparisonResult = if lhs < rhs {
//			.orderedAscending
//		} else if lhs < rhs {
//			.orderedDescending
//		} else {
//			.orderedSame
//		}
//
//		// `.forward = 0` -> `-(0 << 1) + 1 == 1`
//		// `.reverse = 1` -> `-(1 << 1) + 1 == -1`
//		let sortOrderScale = -(sortOrder.rawValue << 1) + 1
//
//		self = Self(rawValue: forwardResult.rawValue * sortOrderScale).unsafelyUnwrapped
	}
}