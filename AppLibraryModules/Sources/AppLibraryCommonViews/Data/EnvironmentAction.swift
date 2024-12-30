public struct EnvironmentAction {
	private let action: () -> Void

	public init(_ action: @escaping () -> Void) {
		self.action = action
	}
}

// MARK: -

public extension EnvironmentAction {
	func callAsFunction() {
		action()
	}
}
