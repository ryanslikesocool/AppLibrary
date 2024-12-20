import AppKit

public extension NSImage {
	static var applicationPlaceholder: NSImage {
		NSWorkspace.shared.icon(for: .applicationPlaceholder)
	}
}
