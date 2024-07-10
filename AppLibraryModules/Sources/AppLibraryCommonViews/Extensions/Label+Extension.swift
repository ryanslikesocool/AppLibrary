import AppLibraryCommon
import SwiftUI

public extension Label<Text, Image> {
	static func showInFinder() -> Self { Self("Show in Finder", image: Constant.Symbol.finder) }
	static func remove() -> Self { Self("Remove", systemImage: Constant.Symbol.trash) }
	static func refresh() -> Self { Self("Refresh", systemImage: Constant.Symbol.arrow_clockwise) }
}
