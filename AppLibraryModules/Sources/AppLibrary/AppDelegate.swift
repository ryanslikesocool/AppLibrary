import AppKit
import AppLibraryBrowserWindow
import AppLibraryStorage
import OSLog

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var mainMenu: MainMenu = MainMenu()
	private(set) lazy var browserWindowController: BrowserWindowController = BrowserWindowController()

	func applicationDidFinishLaunching(_ notification: Notification) {
		Logger.module.debug("Finished launching \(NSApplication.shared.appName).")

		_ = mainMenu

		_ = GeneralSettings.shared
		_ = AppsSettings.shared
		_ = LayoutSettings.shared

		AccessibilityUtility.requestAccess()
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		browserWindowController.reveal()
	}
}