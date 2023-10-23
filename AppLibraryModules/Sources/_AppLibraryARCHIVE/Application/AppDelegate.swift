import Carbon.HIToolbox
import Cocoa
import Settings
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var appLibraryWindowController: AppLibraryWindowController = AppLibraryWindowController()

	private(set) lazy var settingsWindowController = SettingsWindowController(
		panes: [
			Settings.Pane(
				identifier: .display,
				title: "Display",
				toolbarIcon: NSImage(systemSymbolName: "display", accessibilityDescription: "Display")!
			) {
				DisplaySettingsPane()
			},
			Settings.Pane(
				identifier: .directories,
				title: "Directories",
				toolbarIcon: NSImage(systemSymbolName: "folder", accessibilityDescription: "Directories")!
			) {
				DirectoriesSettingsPane()
			},
			Settings.Pane(
				identifier: .apps,
				title: "Apps",
				toolbarIcon: NSImage(systemSymbolName: "app", accessibilityDescription: "Apps")!
			) {
				AppsSettingsPane()
			},
		]
	)

	private let appIconContent: NSImageView = NSImageView(image: NSImage(named: "AppIcon")!)

	func applicationDidFinishLaunching(_ notification: Notification) {
		_ = AppSettings.shared

		DockTileUtilities.requestAccess()

		NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
			self.keyDown(with: event) ? nil : event
		}
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		appLibraryWindowController.reveal()
	}

	func applicationDidResignActive(_ notification: Notification) {
		appLibraryWindowController.dismiss()
		AppSettings.save()
	}

	func applicationWillTerminate(_ notification: Notification) {
		AppSettings.save()
	}
}

private extension AppDelegate {
	func keyDown(with event: NSEvent) -> Bool {
		if Int(event.keyCode) == kVK_Escape {
			appLibraryWindowController.hide()
			return true
		} else {
			return false
		}
	}
}
