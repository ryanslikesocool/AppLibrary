import AppKit
import AppLibraryBrowser
import AppLibraryCommon
import AppLibraryStorage
import OSLog

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var browserWindowController: BrowserWindowController = BrowserWindowController()

	func applicationDidFinishLaunching(_ notification: Notification) {
		Logger.module.debug("Finished launching \(NSApplication.shared.appName).app")

		_ = GeneralSettings.shared
		_ = AppsSettings.shared
		_ = LayoutSettings.shared

		DockUtility.requestAccess()

		createMainMenuItems()
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		browserWindowController.reveal()
	}
}

private extension AppDelegate {
	func createMainMenuItems() {
		// TODO: how to localize "Edit"?
		if let editSubmenu = NSApp.mainMenu?.item(withTitle: "Edit")?.submenu {
			print("create edit submenu items")
			editSubmenu.addItem(withTitle: "Search", action: #selector(activateSearchAction), keyEquivalent: "f")
		}

		// TODO: how to localize "View"?
		if let viewSubmenu = NSApp.mainMenu?.item(withTitle: "View")?.submenu {
			print("create view submenu items")
			viewSubmenu.addItem(withTitle: "Refresh", action: #selector(refreshLibraryAction), keyEquivalent: "r")
		}
	}

	@objc
	func activateSearchAction() {
		Event.activateSearch.send()
	}

	@objc
	func refreshLibraryAction() {
		Event.refreshApps.send()
	}
}
