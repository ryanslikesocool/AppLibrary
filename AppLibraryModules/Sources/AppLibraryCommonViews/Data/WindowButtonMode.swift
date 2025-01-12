/// Modes for standard window buttons (traffic lights).
///
/// ## Topics
/// ### Modifiers
/// - ``SwiftUICore/View/windowButtons(close:miniaturize:zoom:)``
public enum WindowButtonMode {
	/// Indicates that a window button is visible and interactive.
	case enabled

	/// Indicates that a window button is visible, but not interactive.
	case disabled

	/// Indicates that a window button is not visible.
	case hidden
}

// MARK: - Sendable

extension WindowButtonMode: Sendable { }

// MARK: - Equatable

extension WindowButtonMode: Equatable { }

// MARK: - Hashable

extension WindowButtonMode: Hashable { }
