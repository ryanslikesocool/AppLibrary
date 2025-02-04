/// Determine if two objects implementing [`Equatable`]( https://developer.apple.com/documentation/swift/equatable ) are not equal.
///
/// Based on
/// [this approach from Nil Coalescing]( https://nilcoalescing.com/blog/CheckIfTwoValuesOfTypeAnyAreEqual/ ).
///
/// - Parameters:
///   - lhs: The left side of the operation.
///   - rhs: The right side of the operation.
/// - Returns: `true` if the arguments are not equal; `false` otherwise.
public func areNotEqual(_ lhs: any Equatable, _ rhs: any Equatable) -> Bool {
	return a_as_b(lhs, rhs) || a_as_b(rhs, lhs)

	func a_as_b<A, B>(_ a: A, _ b: borrowing B) -> Bool where
		A: Equatable,
		B: Equatable
	{
		if let a = a as? B {
			a != b
		} else {
			true
		}
	}
}

/// Determine if two objects implementing [`Equatable`]( https://developer.apple.com/documentation/swift/equatable ) are not equal.
///
/// Based on
/// [this approach from Nil Coalescing]( https://nilcoalescing.com/blog/CheckIfTwoValuesOfTypeAnyAreEqual/ ).
///
/// - Parameters:
///   - lhs: The left side of the operation.
///   - rhs: The right side of the operation.
/// - Returns: `true` if the arguments are not equal; `false` otherwise.
public func areNotEqual(_ lhs: (any Equatable)?, _ rhs: (any Equatable)?) -> Bool {
	switch (lhs, rhs) {
		case let (lhs?, rhs?): areNotEqual(lhs, rhs)
		case (.none, .none): false
		default: true
	}
}
