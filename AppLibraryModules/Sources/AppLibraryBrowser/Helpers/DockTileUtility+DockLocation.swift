import Cocoa

public extension DockTileUtility {
	enum DockLocation {
		case bottom
		case left
		case right
	}

	static func estimateDockLocation() -> DockLocation {
		guard let visibleFrame = NSScreen.main?.visibleFrame else {
			return .bottom
		}

		if visibleFrame.origin.y != 0 {
			return .bottom
		} else if visibleFrame.origin.x != 0 {
			return .left
		} else {
			return .right
		}
	}
}

// bottom
// (0.0, 0.0, 2560.0, 1440.0)
// (0.0, 69.0, 2560.0, 1346.0)

// left
// (0.0, 0.0, 2560.0, 1440.0)
// (69.0, 0.0, 2491.0, 1415.0)

// right
// (0.0, 0.0, 2560.0, 1440.0)
// (0.0, 0.0, 2491.0, 1415.0)
