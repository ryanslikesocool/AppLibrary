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
}
