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

public extension OptionSet where
	Self: CaseIterable,
	Element == Self
{
	var components: [Self] {
		Self.allCases.filter(contains)
	}

	func enumerated() -> [(offset: Int, element: Self)] {
		Self.allCases
			.enumerated()
			.filter { _, element in
				self.contains(element)
			}
	}
}
