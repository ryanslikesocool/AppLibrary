// MARK: - Subscript

public extension OptionSet {
	subscript(element: Element) -> Bool {
		get { contains(element) }
		set {
			if newValue {
				insert(element)
			} else {
				remove(element)
			}
		}
	}
}

// MARK: - Properties

public extension OptionSet where
	Self: CaseIterable,
	Element == Self
{
	// MARK: components

	var components: [Self] {
		Self.allCases.filter(contains)
	}
}

// MARK: - Functions

public extension OptionSet where
	Self: CaseIterable,
	Element == Self
{
	// MARK: enumerated

	func enumerated() -> [(offset: Int, element: Self)] {
		Self.allCases
			.enumerated()
			.filter { _, element in
				self.contains(element)
			}
	}
}
