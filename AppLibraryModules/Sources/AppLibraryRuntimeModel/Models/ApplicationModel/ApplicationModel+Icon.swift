import AppKit
import AppLibraryCommon

public extension ApplicationModel {
	func getLatestIcon() -> NSImage {
		latestInstance?.getIcon()
			?? NSWorkspace.shared.icon(for: .applicationPlaceholder)
	}
}
