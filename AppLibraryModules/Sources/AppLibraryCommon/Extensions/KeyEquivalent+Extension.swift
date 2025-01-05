import AppKit
import SwiftUI

public extension KeyEquivalent {
	init?(_ string: borrowing String) {
		guard
			string.count == 1,
			let character = string.first
		else {
			return nil
		}
		self.init(character)
	}

	@_disfavoredOverload
	init?(_ string: String?) {
		guard let string else {
			return nil
		}
		self.init(string)
	}

	init?(charactersIn event: NSEvent) {
		self.init(event.characters)
	}

	init?(charactersIgnoringModifiersIn event: NSEvent) {
		self.init(event.charactersIgnoringModifiers)
	}
}
