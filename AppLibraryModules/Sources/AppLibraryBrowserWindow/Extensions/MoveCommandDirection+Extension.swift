import AppLibraryStorage
import SwiftUI

extension MoveCommandDirection {
	func offset(
		for layout: LibraryLayout
	) -> Int {
		// NOTE: In the `list` layout, horizontal directions may cause confusion for users depending on their language direction.
		// In the future, it could be implemented like this:
		/// ```swift
		///	case (.left, .list):
		///		switch Locale.current.language.lineLayoutDirection {
		///			case .leftToRight: 1
		///			case .rightToLeft: -1
		///			default: 0
		///		}
		/// ```
		// However, that doesn't account for languages where the line direction is vertical...
		// We might have to account for `Locale.current.language.characterDirection` as well.
		// This could turn into a very messy indentation pyramid.
		// For now, potentially complex offsets return `0`.

		switch (self, layout) {
			case (.left, .list),
				 (.right, .list): 0
			case (.left, .grid): -1
			case (.right, .grid): 1
			case let (.down, some): some.xDimension
			case let (.up, some): -some.xDimension
			@unknown default: 0
		}
	}

	func getEntryElement<S>(
		ofType: S.Element.Type = S.Element.self
	) -> KeyPath<S, S.Element?> where
		S: BidirectionalCollection
	{
		switch self {
			case .left: \.last
			case .right: \.first
			case .down: \.first
			case .up: \.last
			@unknown default: Self.fatalError(unsupportedCase: self)
		}
	}
}
