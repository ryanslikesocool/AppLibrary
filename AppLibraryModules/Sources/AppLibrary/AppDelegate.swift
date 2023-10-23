import AppKit
import AppLibraryBrowser
import AppLibrarySettings
import AppLibraryCommon

final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var browserWindowController: BrowserWindowController = BrowserWindowController()

	func applicationDidFinishLaunching(_ notification: Notification) {
		AppSettings.shared.prepare()

		DockTileUtility.requestAccess()

		Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { t in
			print(DockTileUtility.accessGranted)
			t.invalidate()
		}
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		browserWindowController.reveal()
	}

	func applicationDidResignActive(_ notification: Notification) {
		browserWindowController.dismiss()
	}
}
