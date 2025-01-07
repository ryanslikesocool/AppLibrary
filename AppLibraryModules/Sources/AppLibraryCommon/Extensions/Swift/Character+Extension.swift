import Foundation

public extension Character {
	// MARK: isAlphanumeric

	/// - Returns: `true` if the value is alphanumeric; `false` otherwise.
	var isAlphanumeric: Bool {
		// TODO: Which implementation is faster?
		// If the second implementation is faster, we can remove the Foundation dependency entirely.

		// NOTE: These implementations may return different values.
		// See the documentation for `Character.isLetter` and `Character.isWholeNumber` for more information.

#if canImport(Foundation)
		CharacterSet(charactersIn: self)
			.isSubset(of: .alphanumerics)
#else
		isLetter || isWholeNumber
#endif
	}

	// MARK: isArrowKey

	/// - Returns: `true` if the value is an arrow key; `false` otherwise.
	var isArrowKey: Bool {
		CharacterSet(charactersIn: self)
			.isSubset(of: .arrowKeys)
	}
}
