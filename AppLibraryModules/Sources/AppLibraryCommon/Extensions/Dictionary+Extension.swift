public extension Dictionary {
	init<S>(_ elements: borrowing S) where
		S: Sequence,
		S.Element == Value,
		Value: Identifiable,
		Value.ID == Key
	{
		self.init(elements.map { element in (element.id, element) }) { _, newValue in
			newValue
		}
	}
}
