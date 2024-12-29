import AppKit

public extension NSImage {
	@MainActor
	static var appIcon: NSImage! {
		NSApplication.shared.applicationIconImage
	}
}