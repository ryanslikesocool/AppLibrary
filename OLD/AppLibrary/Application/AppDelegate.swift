import ALSettings
import AppKit
import Cocoa
import Foundation
import LoveCore
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
	var settings: AppSettings { AppSettings.shared }

	func applicationDidFinishLaunching(_ notification: Notification) {
		if !AXIsProcessTrusted() {
			let alert = NSAlert()
			alert.messageText = "Accessibility Permission Needed"
			alert.informativeText = "This app uses accessibility features to locate the dock icon."
			alert.addButton(withTitle: "Continue")
			if alert.runModal() == .alertFirstButtonReturn {
				let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
				_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
			}
		}

		settings.appDirectories.restoreBookmarks()

		Application.dynamicAppearance = settings.general.appearance

		NSEvent.addLocalMonitorForEvents(
			matching: [.leftMouseDown]
		) { [weak self] in
			guard let self else { return $0 }
			self.openAppLibrary()
//			self.updateEyes()
//			NSApp.dockTile.display()
			return $0
		}
	}

	func openAppLibrary() {
		guard AXIsProcessTrusted() else { return }

		print("tada!")
	}
}
