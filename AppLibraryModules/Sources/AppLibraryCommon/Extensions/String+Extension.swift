public extension String {
	var replaceEmptyWithNil: Self? {
		if isEmpty {
			nil
		} else {
			self
		}
	}
}