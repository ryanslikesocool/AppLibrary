#if canImport(Foundation)
import Foundation
#endif

public extension StringProtocol {
	/// Return a string with the given `prefix` dropped, if possible.
	/// - Parameter prefix: The prefix to check for and drop.
	func dropPrefix<S>(_ prefix: borrowing S) -> SubSequence where
		S: StringProtocol
	{
		let dropCount: Int = if hasPrefix(prefix) {
			prefix.count
		} else {
			0
		}
		return dropFirst(dropCount)
	}

	/// Return a string with the given `suffix` dropped, if possible.
	/// - Parameter suffix: The suffix to check for and drop.
	func dropSuffix<S>(_ suffix: borrowing S) -> SubSequence where
		S: StringProtocol
	{
		let dropCount: Int = if hasSuffix(suffix) {
			suffix.count
		} else {
			0
		}
		return dropLast(dropCount)
	}

	/// - Returns: `true` if the value is alphanumeric; `false` otherwise.
	var isAlphanumeric: Bool {
		// TODO: Which implementation is faster?
		// If the second implementation is faster, we can remove the Foundation dependency entirely.

		// NOTE: These implementations may return different values.
		// See the documentation for `CharacterSet.alphanumerics` for more information.

#if canImport(Foundation)
		CharacterSet(charactersIn: self)
			.isSubset(of: .alphanumerics)
#else
		range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
#endif
	}

	/// - Returns: `true` if the value is an arrow key; `false` otherwise.
	var isArrowKey: Bool {
		CharacterSet(charactersIn: self)
			.isSubset(of: .arrowKeys)
	}
}
