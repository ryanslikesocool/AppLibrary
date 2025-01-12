import SwiftUI
import AppLibraryCommon

public struct _WindowIDViewModifier: ViewModifier {
	private let id: WindowIdentifier

	/// Expose a window's ID to the environment.
	///
	/// - Parameters:
	///   - id: The window's ID.
	nonisolated init(_ id: WindowIdentifier) {
		self.id = id
	}

	public func body(content: Content) -> some View {
		content
			.windowID(id)
	}
}

// MARK: - Convenience

extension View {
	/// Expose a window's ID to the environment.
	///
	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/windowID``
	/// - ``SwiftUI/Scene/windowID(_:)-7gcxi``
	/// - ``SwiftUI/Scene/windowID(_:)-2v85t``
	///
	/// - Parameter id: The window's ID.
	nonisolated func _windowID(
		_ id: WindowIdentifier
	) -> ModifiedContent<Self, _WindowIDViewModifier> {
		modifier(_WindowIDViewModifier(id))
	}
}
