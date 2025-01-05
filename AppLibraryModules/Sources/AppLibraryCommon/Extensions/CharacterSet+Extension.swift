import Foundation
import SwiftUI

// MARK: - Convenience

public extension CharacterSet {
	init<S>(charactersIn string: borrowing S) where
		S: StringProtocol
	{
		self.init(string.unicodeScalars)
	}

	init(charactersIn character: borrowing Character) {
		self.init(character.unicodeScalars)
	}
}

// MARK: - Constants

public extension CharacterSet {
	static var arrowKeys: Self {
		Self(
			[
				KeyEquivalent.leftArrow,
				KeyEquivalent.rightArrow,
				KeyEquivalent.downArrow,
				KeyEquivalent.upArrow,
			]
			.flatMap(\.character.unicodeScalars)
		)
	}
}
