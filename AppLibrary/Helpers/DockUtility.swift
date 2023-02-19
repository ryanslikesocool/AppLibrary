import AppKit
import Foundation

enum DockUtility {
	enum DockPosition: Int {
		case bottom = 0
		case left = 1
		case right = 2
	}

	static var position: DockPosition {
		let screen: NSScreen! = NSScreen.main

		if screen.visibleFrame.origin.y == 0 {
			return screen.visibleFrame.origin.x == 0 ? .right : .left
		} else {
			return .bottom
		}
	}

	static var size: CGFloat {
		let screen: NSScreen! = NSScreen.main

		switch position {
			case .right: return screen.frame.width - screen.visibleFrame.width
			case .left: return screen.visibleFrame.origin.x
			case .bottom: return screen.visibleFrame.origin.y
		}
	}

	static var isHidden: Bool { size < 25 }
}
