import AppKit

public extension DockUtility {
	// private static var menuBarHeight: Double { NSStatusBar.system.thickness }

	/// Estimate the dock position on the screen based on the screen's `visibleFrame`.
	/// - Returns: The dock position on the screen, or `nil` if the dock is hidden.
	static func estimateDockPosition() -> DockPosition? {
		guard let screen = NSScreen.main else {
			return .bottom
		}
		let screenFrame = screen.frame
		let visibleFrame = screen.visibleFrame

		return if visibleFrame.origin.x > screenFrame.origin.x {
			.left
		} else if visibleFrame.origin.y > screenFrame.origin.y {
			.bottom
		} else if visibleFrame.size.width < screenFrame.size.width {
			.right
		} else {
			nil
		}
	}

	/// Estimate the short axis of the dock.
	/// - Returns:The estimated dock height if the dock is at the bottom of the screen, the estimated dock width if the dock is at the left or right side of the screen, or `nil` if the dock is hidden.
	static func estimateDockShortAxis() -> (DockPosition, CGFloat)? {
		guard
			let screen = NSScreen.main,
			let dockPosition = estimateDockPosition()
		else {
			return nil
		}

		let visibleFrame = screen.visibleFrame

		let shortAxis: CGFloat = switch dockPosition {
			case .bottom: visibleFrame.origin.y
			case .left: visibleFrame.origin.x
			case .right: screen.frame.size.width - visibleFrame.size.width
		}

		return (dockPosition, shortAxis)
	}
}

// MARK: - Supporting Data

public extension DockUtility {
	enum DockPosition {
		case left
		case bottom
		case right
	}
}
