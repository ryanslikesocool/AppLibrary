import AppLibraryStorage
import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var removeHideFlagsAction: RemoveHideFlagsAction = RemoveHideFlagsAction { _ in
		preconditionFailure("Attempted to access `removeHideFlagsAction` before it was set.")
	}
}

// MARK: - Convenience

extension View {
	func removeHideFlagsAction(_ action: @escaping (ApplicationModelIdentifier) -> Void) -> some View {
		environment(\.removeHideFlagsAction, RemoveHideFlagsAction(action))
	}
}
