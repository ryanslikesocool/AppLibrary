import AppKit
import AppLibraryBrowser
import AppLibrarySettings
import AppLibraryCommon

final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var browserWindowController: BrowserWindowController = BrowserWindowController()

	func applicationDidFinishLaunching(_ notification: Notification) {
		AppSettings.shared.prepare()

		DockTileUtility.requestAccess()
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		browserWindowController.reveal()
	}

	func applicationDidResignActive(_ notification: Notification) {
		browserWindowController.dismiss()
	}
}
