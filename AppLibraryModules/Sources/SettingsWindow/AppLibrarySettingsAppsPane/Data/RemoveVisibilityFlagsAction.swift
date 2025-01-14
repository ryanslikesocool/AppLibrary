import AppLibraryStorage

struct RemoveVisibilityFlagsAction {
	private let action: (ApplicationModelIdentifier) -> Void

	public init(_ action: @escaping (ApplicationModelIdentifier) -> Void) {
		self.action = action
	}
}

// MARK: -

extension RemoveVisibilityFlagsAction {
	func callAsFunction(_ applicationModelIdentifier: ApplicationModelIdentifier) {
		action(applicationModelIdentifier)
	}
}
