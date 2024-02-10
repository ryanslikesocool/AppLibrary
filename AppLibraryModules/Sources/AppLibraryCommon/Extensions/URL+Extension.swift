import AppKit

public extension URL {
	func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting([self])
	}
}
