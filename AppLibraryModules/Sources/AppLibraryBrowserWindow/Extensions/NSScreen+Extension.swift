import AppKit

extension NSScreen {
	/// Estimate the dock position on the screen based on the screen's `visibleFrame`.
	/// - Returns: The dock position on the screen, or `nil` if the dock is hidden.
	var estimatedDockPosition: DockPosition? {
		let fullFrame = frame
		let visibleFrame = visibleFrame

		return if visibleFrame.origin.x > fullFrame.origin.x {
			.left
		} else if visibleFrame.origin.y > fullFrame.origin.y {
			.bottom
		} else if visibleFrame.size.width < fullFrame.size.width {
			.right
		} else {
			nil
		}
	}

	/// Estimate the short axis of the dock.
	/// - Returns:The estimated dock height if the dock is at the bottom of the screen, the estimated dock width if the dock is at the left or right side of the screen, or `nil` if the dock is hidden.
	var estimatedDockShortAxis: (dockPosition: DockPosition, shortLength: CGFloat)? {
		guard let dockPosition = estimatedDockPosition else {
			return nil
		}

		let visibleFrame = visibleFrame
		let shortLength: CGFloat = switch dockPosition {
			case .bottom: visibleFrame.origin.y
			case .left: visibleFrame.origin.x
			case .right: frame.size.width - visibleFrame.size.width
		}

		return (dockPosition, shortLength)
	}
}
