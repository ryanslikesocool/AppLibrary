import AppKit
import AppLibraryBrowserWindow
import AppLibraryStorage
import OSLog

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var browserWindowController: BrowserWindowController = BrowserWindowController()

	func applicationDidFinishLaunching(_ notification: Notification) {
		Logger.module.debug("Finished launching \(NSApplication.shared.appName).")

		_ = GeneralSettings.shared
		_ = AppsSettings.shared
		_ = LayoutSettings.shared
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		browserWindowController.reveal()
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		false
	}
}
