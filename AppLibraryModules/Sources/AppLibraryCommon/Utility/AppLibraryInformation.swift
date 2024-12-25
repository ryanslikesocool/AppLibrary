import AppKit

public enum AppLibraryInformation {
	@MainActor
	public static var appIcon: NSImage {
		NSApplication.shared.applicationIconImage
	}
}
