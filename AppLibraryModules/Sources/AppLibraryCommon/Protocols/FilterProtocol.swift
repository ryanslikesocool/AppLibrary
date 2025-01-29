public protocol FilterProtocol {
	associatedtype Subject

	func filter(subjects: [Subject]) -> [Subject]
}