/// ## Discussion
/// Use the ``SwiftUICore/EnvironmentValues/delete`` environment value to get the instance of this structure for a given
/// [`Environment`]( https://developer.apple.com/documentation/swiftui/environment ).
/// Then call the instance to perform the dismissal.
/// You call the instance directly because it defines a ``callAsFunction()`` method that Swift calls when you call the instance.
public struct DeleteAction {
	private let action: () -> Void

	init?(_ action: (() -> Void)?) {
		guard let action else {
			return nil
		}
		self.action = action
	}
}

// MARK: -

public extension DeleteAction {
	func callAsFunction() {
		action()
	}
}
