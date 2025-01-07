import AppLibraryAboutWindow
import AppLibraryBrowserWindow
import AppLibraryCommon
import AppLibrarySettingsWindow
import OSLog
import SwiftUI

@main
public struct App: SwiftUI.App {
	@NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

	public init() {
		Logger.module.debug("Started launching \(NSApplication.shared.appName).")
	}

	public var body: some Scene {
//		AboutWindow()

		SettingsWindow()
			.commands {
				MainMenu()
			}
	}
}
