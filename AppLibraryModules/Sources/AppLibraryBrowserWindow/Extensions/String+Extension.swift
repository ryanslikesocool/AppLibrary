extension String {
	var isAlphanumeric: Bool {
		!isEmpty
		&& range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
	}
}
