import ALSettings
import AppKit
import Foundation
import LoveCore
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
	var settings: AppSettings { AppSettings.shared }

	func applicationDidFinishLaunching(_ notification: Notification) {
		settings.appDirectories.restoreBookmarks()

		Application.setAppearance(settings.general.appearance)
		NotificationCenter.default.addObserver(.appearanceChanged) { userInfo in
			Application.setAppearance(userInfo?["appearance"] as? Appearance)
		}
	}
}
