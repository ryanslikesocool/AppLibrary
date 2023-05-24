import Carbon.HIToolbox
import Cocoa
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	private let appLibraryWindowController: AppLibraryWindowController = AppLibraryWindowController()

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
