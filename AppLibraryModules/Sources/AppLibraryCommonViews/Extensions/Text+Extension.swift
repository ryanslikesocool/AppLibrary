import AppLibraryCommon
import SwiftUI

public extension Text {
	init(url: URL) {
		self.init(url.abbreviatingWithTildeInPath)
	}
}
