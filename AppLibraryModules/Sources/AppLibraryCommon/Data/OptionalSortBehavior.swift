/// Determines how to handle `nil` objects in a sort comparator.
public enum OptionalSortBehavior {
	/// Sort `nil` object earlier than non-`nil` objects.
	case nilFirst

	/// Sort `nil` object later than non-`nil` objects.
	case nilLast

	/// Sort `nil` objects the same as non-`nil` objects.
	case same
}

// MARK: - Sendable

extension OptionalSortBehavior: Sendable { }

// MARK: - Equatable

extension OptionalSortBehavior: Equatable { }

// MARK: - Hashable

extension OptionalSortBehavior: Hashable { }
