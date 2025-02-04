public extension Array {
	// MARK: filter

	func filter<Filter>(using filter: Filter) -> [Element] where
		Filter: FilterProtocol,
		Filter.Subject == Element
	{
		filter.filter(subjects: self)
	}
}
