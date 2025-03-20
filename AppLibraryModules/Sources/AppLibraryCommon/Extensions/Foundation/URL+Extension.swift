import AppKit
import Foundation

public extension URL {
	var abbreviatingWithTildeInPath: String {
		(path(percentEncoded: false) as NSString).abbreviatingWithTildeInPath
	}

	var expandingTildeInPath: String {
		(path(percentEncoded: false) as NSString).expandingTildeInPath
	}

	func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting([self])
	}
}

public extension Sequence where
	Element == URL
{
	func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting(Array(self))
	}
}