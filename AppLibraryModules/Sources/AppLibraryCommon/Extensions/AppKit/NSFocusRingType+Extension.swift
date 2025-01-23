import AppKit

public extension NSFocusRingType {
	init(isEnabled: Bool) {
		self = if isEnabled {
			.default
		} else {
			.none
		}
	}
}