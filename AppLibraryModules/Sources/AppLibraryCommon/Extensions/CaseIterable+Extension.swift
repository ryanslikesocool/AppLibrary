public extension CaseIterable {
	init?<Value>(
		where keyPath: KeyPath<AllCases.Element, Value>,
		equals equalityValue: Value
	) where
		Value: Equatable
	{
		guard let value = Self
			.allCases
			.first(where: { element in
				element[keyPath: keyPath] == equalityValue
			})
		else {
			return nil
		}
		self = value
	}
}