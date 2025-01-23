import AppKit
import AppLibraryCommon
import SwiftUI

public struct NSTextFieldStyle {
	/// The value to apply to
	/// [`drawsBackground`]( https://developer.apple.com/documentation/appkit/nstextfield/drawsbackground ).
	public let drawsBackground: Bool?

	/// The value to apply to
	/// [`isBezeled`]( https://developer.apple.com/documentation/appkit/nstextfield/isbezeled ).
	public let isBezeled: Bool?

	/// The value to apply to
	/// [`bezelStyle`]( https://developer.apple.com/documentation/appkit/nstextfield/bezelstyle-swift.property ).
	public let bezelStyle: NSTextField.BezelStyle?

	/// The value to apply to
	/// [`backgroundColor`]( https://developer.apple.com/documentation/appkit/nstextfield/backgroundcolor ).
	public let backgroundColor: Color?

	/// The value to apply to
	/// [`textColor`]( https://developer.apple.com/documentation/appkit/nstextfield/textcolor ).
	public let textColor: Color?

	/// - Parameters:
	///   - drawsBackground: The value to apply to
	///   [`drawsBackground`]( https://developer.apple.com/documentation/appkit/nstextfield/drawsbackground ).
	///   Set this value to `nil` to use the default value.
	///   - isBezeled: The value to apply to
	///   [`isBezeled`]( https://developer.apple.com/documentation/appkit/nstextfield/isbezeled ).
	///   Set this value to `nil` to use the default value.
	///   - bezelStyle: The value to apply to
	///   [`bezelStyle`]( https://developer.apple.com/documentation/appkit/nstextfield/bezelstyle-swift.property ).
	///   Set this value to `nil` to use the default value.
	///   - backgroundColor: The value to apply to
	///   [`backgroundColor`]( https://developer.apple.com/documentation/appkit/nstextfield/backgroundcolor ).
	///   Set this value to `nil` to use the default value.
	///   - textColor: The value to apply to
	///   [`textColor`]( https://developer.apple.com/documentation/appkit/nstextfield/textcolor ).
	///   Set this value to `nil` to use the default value.
	public init(
		drawsBackground: Bool? = nil,
		isBezeled: Bool? = nil,
		bezelStyle: NSTextField.BezelStyle? = nil,
		backgroundColor: Color? = nil,
		textColor: Color? = nil
	) {
		self.drawsBackground = drawsBackground
		self.isBezeled = isBezeled
		self.bezelStyle = bezelStyle
		self.backgroundColor = backgroundColor
		self.textColor = textColor
	}
}

// MARK: -

extension NSTextFieldStyle {
	/// Apply the style to the given `textField`.
	///
	/// - Parameter textField: The `NSTextField` to apply the style to.
	@MainActor
	func apply(to textField: NSTextField) {
		updating(&textField.drawsBackground, with: drawsBackground)
		updating(&textField.isBezeled, with: isBezeled)
		updating(&textField.bezelStyle, with: bezelStyle)
		updating(&textField.backgroundColor, with: backgroundColor, transform: NSColor.init(_:))
		updating(&textField.textColor, with: textColor, transform: NSColor.init(_:))
	}
}
