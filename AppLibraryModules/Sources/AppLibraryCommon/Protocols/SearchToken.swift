public protocol SearchToken: Identifiable, FilterProtocol { }

// MARK: - Intrinsic

public extension Sequence where
	Element: SearchToken
{
	func filter(subjects: [Element.Subject]) -> [Element.Subject] {
		var result = subjects

		for token in self {
			result = token.filter(subjects: result)
		}

		return result
	}
}
