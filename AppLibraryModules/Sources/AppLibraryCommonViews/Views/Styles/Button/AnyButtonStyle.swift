import SwiftUI

/// A type-erasing wrapper around
/// [`ButtonStyle`]( https://developer.apple.com/documentation/swiftui/buttonstyle )
/// and
/// [`PrimitiveButtonStyle`]( https://developer.apple.com/documentation/swiftui/primitivebuttonstyle ).
public struct AnyButtonStyle: PrimitiveButtonStyle {
	private let internalStyle: InternalStyle

	fileprivate nonisolated init(internalStyle: InternalStyle) {
		self.internalStyle = internalStyle
	}

	public func makeBody(configuration: Configuration) -> some View {
		switch internalStyle {
			case let .buttonStyle(style):
				makeButton(configuration: configuration)
					.buttonStyle(style)
			case let .primitiveButtonStyle(style):
				makeButton(configuration: configuration)
					.buttonStyle(style)
		}
	}

	private nonisolated func makeButton(configuration: Configuration) -> some View {
		Button(role: configuration.role, action: configuration.trigger) { configuration.label }
	}
}

// MARK: - Supporting Data

private extension AnyButtonStyle {
	enum InternalStyle {
		case buttonStyle(_AnyButtonStyle)
		case primitiveButtonStyle(_AnyPrimitiveButtonStyle)
	}

	/// ## See Also
	/// - ``InternalStyle/buttonStyle(_:)``
	struct _AnyButtonStyle: ButtonStyle {
		private let _makeBody: (Configuration) -> AnyView

		public init<S>(_ style: S) where
			S: ButtonStyle
		{
			_makeBody = if let style = style as? Self {
				style._makeBody
			} else {
				{ configuration in
					AnyView(style.makeBody(configuration: configuration))
				}
			}
		}

		public func makeBody(configuration: Configuration) -> some View {
			_makeBody(configuration)
		}
	}

	/// ## See Also
	/// - ``InternalStyle/primitiveButtonStyle(_:)``
	struct _AnyPrimitiveButtonStyle: PrimitiveButtonStyle {
		private let _makeBody: (Configuration) -> AnyView

		public init<S>(_ style: S) where
			S: PrimitiveButtonStyle
		{
			_makeBody = if let style = style as? Self {
				style._makeBody
			} else {
				{ configuration in
					AnyView(style.makeBody(configuration: configuration))
				}
			}
		}

		public func makeBody(configuration: Configuration) -> some View {
			_makeBody(configuration)
		}
	}
}

// MARK: - Convenience

public extension AnyButtonStyle {
	/// Create a type-erased button style.
	/// - Parameter style: The underlying button style.
	init<S>(_ style: S) where
		S: ButtonStyle
	{
		self.init(internalStyle: .buttonStyle(_AnyButtonStyle(style)))
	}

	/// Create a type-erased button style.
	/// - Parameter style: The underlying button style.
	init<S>(_ style: S) where
		S: PrimitiveButtonStyle
	{
		if let style = style as? Self {
			self.init(internalStyle: style.internalStyle)
		} else {
			self.init(internalStyle: .primitiveButtonStyle(_AnyPrimitiveButtonStyle(style)))
		}
	}
}
