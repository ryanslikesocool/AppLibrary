import AppKit

public extension NSImage {
	@MainActor
	static var appIcon: NSImage! {
		NSApplication.shared.applicationIconImage
	}

	static var applicationPlaceholder: NSImage {
		NSWorkspace.shared.icon(for: .applicationPlaceholder)
	}
}
