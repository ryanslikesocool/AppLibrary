public struct EnvironmentAction<each Input> {
	private let action: (repeat each Input) -> Void

	public init(_ action: @escaping (repeat each Input) -> Void) {
		self.action = action
	}
}

// MARK: -

public extension EnvironmentAction {
	func callAsFunction(_ input: repeat each Input) {
		action(repeat each input)
	}
}
