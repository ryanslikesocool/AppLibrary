import AppKit
import AppLibraryCommon

public extension ApplicationModel {
	func getLatestIcon() -> NSImage {
		latestInstance?.getIcon()
			?? NSImage.applicationPlaceholder
	}
}

public extension ApplicationModel? {
	func getLatestIcon() -> NSImage {
		self?.getLatestIcon()
			?? NSImage.applicationPlaceholder
	}
}
