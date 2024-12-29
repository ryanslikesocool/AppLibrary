public extension Dictionary {
	init<S>(_ elements: borrowing S) where
		S: Sequence,
		S.Element == Value,
		Value: Identifiable,
		Value.ID == Key
	{
		self.init(
			elements.map { element in (element.id, element) }
		) { _, newValue in
			newValue
		}
	}

	func mapKeys<ResultKey>(
		_ transform: (Key) throws -> ResultKey,
		uniquingKeysWith combine: (Value, Value) throws -> Value
	) rethrows -> [ResultKey: Value] where
		ResultKey: Hashable
	{
		try [ResultKey: Value](
			map { key, value in
				try (transform(key), value)
			},
			uniquingKeysWith: combine
		)
	}
}
