import AppLibraryStorage
import SwiftUI

extension MoveCommandDirection {
	func offset(for layout: LibraryLayout) -> Int {
		switch (self, layout) {
			case (.left, _): -1
			case (.right, _): 1
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
