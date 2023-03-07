import AppKit
import Foundation
import LoveCore
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
	@Published var state: AppState = AppState()
	@Published var settings: AppSettings = AppSettings()

	func applicationDidFinishLaunching(_ notification: Notification) {
		state.load()

		setAppearance(AppSettings.get(for: .appearance))
		NotificationCenter.default.addObserver(.appearanceChanged) { userInfo in
			guard let appearance = userInfo?["appearance"] as? String else {
				return
			}
			self.setAppearance(appearance)
		}
	}

	func applicationWillTerminate(_ notification: Notification) {
		state.unload()
	}

	internal func setAppearance(_ theme: String?) {
		switch theme {
			case "Light": NSApp.appearance = ColorScheme.light.nativeAppearance
			case "Dark": NSApp.appearance = ColorScheme.dark.nativeAppearance
			default: NSApp.appearance = nil
		}
	}

//	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
//		if
//			let dockTileView = sender.dockTile.contentView,
//			let dockTileSuperview = dockTileView.superview
//		{
//			let point = NSAccessibility.screenPoint(fromView: dockTileView, point: .zero)
//			//let rect = NSAccessibility.screenRect(fromView: dockTileView, rect: dockTileView.bounds)
//			print(point)
//		}
//		return flag
//	}

//	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
//		false
//	}
}
