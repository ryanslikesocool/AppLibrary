import AppKit
import AppLibraryCommon
import SwiftUI

@MainActor
public extension EnvironmentValues {
	/// Apply the environment values to the given `NSView`.
	func apply(to nsView: NSView) {
		updating(&nsView.focusRingType, with: isFocusEffectEnabled, transform: NSFocusRingType.init(isEnabled:))
	}

	/// Apply the environment values to the given `NSControl`.
	///
	/// - Remark: This function also calls ``apply(to:)-92q8i`` for `NSView`.
	func apply(to nsControl: NSControl) {
		apply(to: nsControl as NSView)

		updating(&nsControl.isEnabled, with: isEnabled)
		updating(&nsControl.controlSize, with: controlSize, transform: NSControl.ControlSize.init(_:))
	}

	/// Apply the environment values to the given `NSTextField`.
	///
	/// - Remark: This function also calls ``apply(to:)-25pqb`` for `NSControl`.
	func apply(to nsTextField: NSTextField) {
		apply(to: nsTextField as NSControl)

		updating(&nsTextField.placeholderString, with: nsTextFieldPlaceholderString)
		updating(&nsTextField.isSelectable, with: isEnabled)

		nsTextFieldStyle.apply(to: nsTextField)
	}
}
