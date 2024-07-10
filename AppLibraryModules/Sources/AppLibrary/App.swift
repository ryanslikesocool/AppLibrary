import AppLibraryAbout
import AppLibraryBrowser
import AppLibraryCommon
import AppLibrarySettingsViews
import OSLog
import SwiftUI

@main public struct App: SwiftUI.App {
	@NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

	public init() {
		Logger.module.debug("Did launch \(AppLibraryInformation.appName).app")
	}

	public var body: some Scene {
//		AboutWindow()
		SettingsWindow()
	}
}
