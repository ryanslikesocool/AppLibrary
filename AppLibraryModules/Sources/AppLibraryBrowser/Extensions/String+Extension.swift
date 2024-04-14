extension String {
	var isAlphanumeric: Bool {
		return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
	}
}
