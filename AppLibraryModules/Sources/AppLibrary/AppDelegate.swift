import AppKit
import AppLibraryBrowser
import AppLibraryCommon
import AppLibraryStorage
import OSLog

final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var browserWindowController: BrowserWindowController = BrowserWindowController()

	func applicationDidFinishLaunching(_ notification: Notification) {
		Logger.module.debug("Did finish launching \(AppLibraryInformation.appName).app")

		AppSettings.shared.prepare()

		DockUtility.requestAccess()
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		browserWindowController.reveal()
	}
}
