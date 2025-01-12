import SwiftUI

/// A button style that expands the label inside of the bezel.
public struct ExpandingLabelButtonStyle: PrimitiveButtonStyle {
	private let innerStyle: AnyButtonStyle

	private let maxWidth: CGFloat?
	private let maxHeight: CGFloat?

	/// Create an expanding button style.
	/// - Parameters:
	///   - axes: The axes to expand.
	///   - innerStyle: The underlying style of the button.
	fileprivate nonisolated init(
		axes: Axis.Set,
		innerStyle: AnyButtonStyle
	) {
		self.innerStyle = innerStyle

		maxWidth = axes.contains(.horizontal) ? .infinity : nil
		maxHeight = axes.contains(.vertical) ? .infinity : nil
	}

	public func makeBody(configuration: Configuration) -> some View {
		Button(role: configuration.role, action: configuration.trigger) {
			configuration.label
				.frame(
					maxWidth: maxWidth,
					maxHeight: maxHeight
				)
		}
		.buttonStyle(innerStyle)
	}
}

// MARK: - Convenience

public extension ExpandingLabelButtonStyle {
	/// Create an expanding button style.
	/// - Parameters:
	///   - axes: The axes to expand.
	init(
		_ axes: Axis.Set
	) {
		self.init(axes: axes, innerStyle: AnyButtonStyle(.automatic))
	}

	/// Create an expanding button style.
	/// - Parameters:
	///   - axes: The axes to expand.
	///   - innerStyle: The underlying style of the button.
	init<S>(
		_ axes: Axis.Set,
		innerStyle: S
	) where
		S: PrimitiveButtonStyle
	{
		self.init(axes: axes, innerStyle: AnyButtonStyle(innerStyle))
	}

	/// Create an expanding button style.
	/// - Parameters:
	///   - axes: The axes to expand.
	///   - innerStyle: The underlying style of the button.
	init<S>(
		_ axes: Axis.Set,
		innerStyle: S
	) where
		S: ButtonStyle
	{
		self.init(axes: axes, innerStyle: AnyButtonStyle(innerStyle))
	}
}

public extension PrimitiveButtonStyle where
	Self == ExpandingLabelButtonStyle
{
	/// Create an expanding button style.
	/// - Parameters:
	///   - axes: The axes to expand.
	static func expandingLabel(
		_ axes: Axis.Set
	) -> Self {
		Self(axes, innerStyle: .automatic)
	}

	/// Create an expanding button style.
	/// - Parameters:
	///   - axes: The axes to expand.
	///   - innerStyle: The underlying style of the button.
	static func expandingLabel<S>(
		_ axes: Axis.Set,
		innerStyle: S
	) -> Self where
		S: PrimitiveButtonStyle
	{
		Self(axes, innerStyle: innerStyle)
	}

	/// Create an expanding button style.
	/// - Parameters:
	///   - axes: The axes to expand.
	///   - innerStyle: The underlying style of the button.
	static func expandingLabel<S>(
		_ axes: Axis.Set,
		innerStyle: S
	) -> Self where
		S: ButtonStyle
	{
		Self(axes, innerStyle: innerStyle)
	}
}

public extension PrimitiveButtonStyle {
	/// - Parameters:
	///   - axes: The axes to expand.
	func expandingLabel(
		_ axes: Axis.Set
	) -> ExpandingLabelButtonStyle {
		ExpandingLabelButtonStyle(axes, innerStyle: self)
	}
}

public extension ButtonStyle {
	/// - Parameters:
	///   - axes: The axes to expand.
	func expandingLabel(
		_ axes: Axis.Set
	) -> ExpandingLabelButtonStyle {
		ExpandingLabelButtonStyle(axes, innerStyle: self)
	}
}
