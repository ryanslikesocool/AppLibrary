import SwiftUI
import AppLibraryCommon

public extension EnvironmentValues {
	/// The current window ID.
	///
	/// - Remark: This value is only available if ``SwiftUI/Scene/windowID(_:)-5gt9k`` was used on the containing scene, or if a scene initializer that receives a ``WindowIdentifier`` was used.
	///
	/// ## See Also
	/// - ``SwiftUI/Scene/windowID(_:)-5gt9k``
	/// - ``SwiftUI/Scene/windowID(_:)-929hs``
	@Entry
	fileprivate(set) var windowID: WindowIdentifier? = nil
}

// MARK: - Convenience

public extension Scene {
	/// Expose a window's ID to the environment.
	///
	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/windowID``
	/// - ``SwiftUI/Scene/windowID(_:)-929hs``
	///
	/// - Parameter id: The window's ID.
	nonisolated func windowID(
		_ id: WindowIdentifier
	) -> some Scene {
		environment(\.windowID, id)
	}

	/// Expose a window's ID to the environment.
	///
	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/windowID``
	/// - ``SwiftUI/Scene/windowID(_:)-5gt9k``
	///
	/// - Parameter id: The window's ID.
	nonisolated func windowID<S>(
		_ id: S
	) -> some Scene where
		S: StringProtocol
	{
		windowID(WindowIdentifier(rawValue: id))
	}
}

extension View {
	/// Expose a window's ID to the environment.
	///
	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/windowID``
	/// - ``SwiftUI/Scene/windowID(_:)-5gt9k``
	/// - ``SwiftUI/Scene/windowID(_:)-929hs``
	///
	/// - Parameter id: The window's ID.
	nonisolated func windowID(
		_ id: WindowIdentifier
	) -> some View {
		environment(\.windowID, id)
	}
}
