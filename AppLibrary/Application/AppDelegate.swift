import AppKit
import Foundation
import LoveCore
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
	@Published var state: AppState = AppState()
	@Published var settings: AppSettings = AppSettings()

//	func applicationDidFinishLaunching(_ notification: Notification) {
//		let dockIcon = AppInformation.appIcon
//		let dockTile = NSApplication.shared.dockTile
//		dockTile.contentView = NSImageView(image: dockIcon)
//		dockTile.display()
//	}

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
