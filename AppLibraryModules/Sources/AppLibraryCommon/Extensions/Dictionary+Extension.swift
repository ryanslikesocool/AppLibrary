public extension Dictionary {
	init<S>(_ elements: borrowing S) where
		S: Sequence,
		S.Element == Value,
		Value: Identifiable,
		Value.ID == Key
	{
		self = elements.reduce(into: Self()) { partialResult, element in
			partialResult[element.id] = element
		}
	}
}
