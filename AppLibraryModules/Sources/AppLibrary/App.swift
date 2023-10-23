import AppLibraryAbout
import AppLibraryBrowser
import AppLibrarySettings
import SwiftUI

@main public struct App: SwiftUI.App {
	@NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

	public init() { }

	public var body: some Scene {
//		AboutWindow()
		SettingsWindow()
	}
}
