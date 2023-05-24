import Carbon.HIToolbox
import Cocoa
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	private let appLibraryWindowController: AppLibraryWindowController = AppLibraryWindowController()

	private let appIconContent: NSImageView = NSImageView(image: NSImage(named: "AppIcon")!)

	func applicationDidFinishLaunching(_ notification: Notification) {
		if !AXIsProcessTrusted() {
			let alert = NSAlert()
			alert.messageText = "Accessibility Permission Needed"
			alert.informativeText = "App Library uses accessibility features to locate the dock icon."
			alert.addButton(withTitle: "Continue")
			if alert.runModal() == .alertFirstButtonReturn {
				let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
				_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
			}
		}

		_ = AppSettings.shared

		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			if self.keyDown(with: $0) {
				return nil // needed to get rid of purr sound
			} else {
				return $0
			}
		}
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		false
	}

//	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
//		true
//	}

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
