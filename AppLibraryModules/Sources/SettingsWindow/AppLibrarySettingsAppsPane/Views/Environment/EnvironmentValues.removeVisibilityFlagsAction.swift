import AppLibraryStorage
import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var removeVisibilityFlagsAction: RemoveVisibilityFlagsAction = RemoveVisibilityFlagsAction { _ in
		preconditionFailure("Attempted to access `removeVisibilityFlagsAction` before it was set.")
	}
}

// MARK: - Convenience

extension View {
	func removeVisibilityFlagsAction(
		_ action: @escaping (ApplicationModelIdentifier) -> Void
	) -> some View {
		environment(\.removeVisibilityFlagsAction, RemoveVisibilityFlagsAction(action))
	}
}
