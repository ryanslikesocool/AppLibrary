import AppKit
import AppLibraryAccessibilityHelperCommon
import ApplicationServices
import AXToolbox

// MARK: - Estimated Position

public extension Dock {
	/// Estimate the dock position on the given `screen`.
	/// - Parameter screen: The screen look for the dock on.
	/// - Returns: The edge on the given `screen` that the dock lies on, or `nil` if the dock is hidden or not on the screen.
	func estimatedEdge(
		on screen: NSScreen,
		elementPosition: @autoclosure () -> CGPoint? = nil
	) -> DockEdge? {
		lazy var elementPosition = elementPosition()

#if DEBUG
		return if FeatureFlag.Dock.logEdgeEstimationImplementationResultComparison {
			logComparison()
		} else {
			execute(implementation: FeatureFlag.Dock.edgeEstimationImplementation)
		}

		func logComparison() -> DockEdge? {
			let results: [(implementation: DockEdgeEstimationImplementation, value: DockEdge?)] = DockEdgeEstimationImplementation.allCases
				.map { implementation in
					(implementation, execute(implementation: implementation))
				}
			let resultString = results
				.map { implementation, value in
					"- \(implementation): \(String(describing: value))"
				}
				.joined(separator: "\n")

			Self.logger.debug("""
			Dock Edge:
			\(resultString)
			""")

			return results
				.first(where: { implementation, _ in implementation == FeatureFlag.Dock.edgeEstimationImplementation })?
				.value
		}
#else
		return execute(implementation: FeatureFlag.Dock.positionEstimationImplementation)
#endif

		func execute(implementation: DockEdgeEstimationImplementation) -> DockEdge? {
			// The `.screenRect` implementation is almost certainly faster,
			// but I still want to validate that results are correct.

			switch implementation {
				case .screenRect: estimatedEdge_screenRect(on: screen)
				case .accessibilityElement: estimatedEdge_accessibilityElement(on: screen, elementPosition: elementPosition)
			}
		}
	}

	/// Estimate the dock position on the given `screen` based on the screen's `visibleFrame`.
	/// - Parameter screen: The screen look for the dock on.
	/// - Returns: The edge of the given `screen` that the dock lies on, or `nil` if the dock is hidden or not on the screen.
	private func estimatedEdge_screenRect(on screen: NSScreen) -> DockEdge? {
		let fullFrame = screen.frame
		let visibleFrame = screen.visibleFrame

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

	/// Estimate the dock position on the given `screen`.
	/// - Parameter screen: The screen look for the dock on.
	/// - Returns: The edge of the given `screen` that the dock lies on, or `nil` if the dock is hidden or not on the screen.
	private func estimatedEdge_accessibilityElement(
		on screen: NSScreen,
		elementPosition: CGPoint?
	) -> DockEdge? {
		guard
			let orientation = try? listElement.value(forAttribute: .orientation),
			let elementPosition = elementPosition ?? (try? listElement.value(forAttribute: .position))
		else {
			return nil
		}

		// TODO: Account for the dock being hidden.

		return switch orientation {
			case .horizontal: .bottom
			case .vertical:
				if elementPosition.x < screen.frame.midX {
					.left
				} else {
					.right
				}
			case .unknown: nil
			default: nil
		}
	}
}

// MARK: - Frame

public extension Dock {
	var rect: CGRect? {
		try? listElement.value(forAttribute: .frame)
	}
}

// MARK: - FrameAndEstimatedPosition

public extension Dock {
	/// - Parameter screen: The screen look for the dock on.
	func rectAndEstimatedEdge(on screen: NSScreen) -> (rect: CGRect, estimatedEdge: DockEdge)? {
		guard
			let rect = try? listElement.value(forAttribute: .frame),
			let estimatedEdge = estimatedEdge(on: screen, elementPosition: rect.origin)
		else {
			return nil
		}

		return (rect, estimatedEdge)
	}
}

// MARK: - Short Axis

public extension Dock {
	// TODO: Figure out why this was implemented.
//	/// Estimate the short axis of the dock.
//	/// - Returns:The estimated dock height if the dock is at the bottom of the screen, the estimated dock width if the dock is at the left or right side of the screen, or `nil` if the dock is hidden.
//	func estimatedShortAxis(on screen: NSScreen) -> (dockEdge: DockEdge, shortLength: CGFloat)? {
//		guard let dockEdge = estimatedEdge(on: screen) else {
//			return nil
//		}
//
//		let visibleFrame = screen.visibleFrame
//		let shortLength: CGFloat = switch dockEdge {
//			case .bottom: visibleFrame.origin.y
//			case .left: visibleFrame.origin.x
//			case .right: screen.frame.size.width - visibleFrame.size.width
//		}
//
//		return (dockEdge, shortLength)
//	}
}
