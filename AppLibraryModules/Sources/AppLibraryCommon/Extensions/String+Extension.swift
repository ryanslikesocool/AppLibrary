public extension StringProtocol {
	func dropPrefix(_ prefix: borrowing some StringProtocol) -> String {
		guard hasPrefix(prefix) else {
			return String(self)
		}
		return String(dropFirst(prefix.count))
	}

	func dropSuffix(_ suffix: borrowing some StringProtocol) -> String {
		guard hasSuffix(suffix) else {
			return String(self)
		}
		return String(dropLast(suffix.count))
	}
}
