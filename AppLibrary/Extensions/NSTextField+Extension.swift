import AppKit
import Foundation

extension NSTextField {
	override open var focusRingType: NSFocusRingType {
		get { .none }
		set { }
	}
}
