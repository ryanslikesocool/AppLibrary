import AppKit
import Foundation
import LoveCore
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
	@Published var state: AppState = AppState()
	@Published var settings: AppSettings = AppSettings()

	func applicationDidFinishLaunching(_ notification: Notification) {
		state.load()

		setAppearance(settings.appearance.colorScheme)
		NotificationCenter.default.addObserver(.appearanceChanged) { userInfo in
			self.setAppearance(userInfo?["appearance"] as? ColorScheme)
		}
	}

	func applicationWillTerminate(_ notification: Notification) {
		state.unload()
	}

	internal func setAppearance(_ colorScheme: ColorScheme?) {
		NSApp.appearance = colorScheme?.nativeAppearance
	}
}
