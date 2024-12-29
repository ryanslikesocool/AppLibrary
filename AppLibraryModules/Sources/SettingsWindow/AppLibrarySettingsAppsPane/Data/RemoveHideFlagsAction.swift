import AppLibraryStorage

struct RemoveHideFlagsAction {
	private let action: (ApplicationModelIdentifier) -> Void

	public init(_ action: @escaping (ApplicationModelIdentifier) -> Void) {
		self.action = action
	}
}

// MARK: -

extension RemoveHideFlagsAction {
	func callAsFunction(_ applicationModelIdentifier: ApplicationModelIdentifier) {
		action(applicationModelIdentifier)
	}
}