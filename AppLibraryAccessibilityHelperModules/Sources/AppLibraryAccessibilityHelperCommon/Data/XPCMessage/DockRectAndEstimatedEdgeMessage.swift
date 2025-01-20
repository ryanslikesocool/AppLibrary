import AppLibraryExtensionCommon
import CoreGraphics

public struct DockRectAndEstimatedEdgeMessage: AccessibilityHelperMessageProtocol {
	public init() { }
}

// MARK: - Request

public extension DockRectAndEstimatedEdgeMessage {
	struct Request: XPCMessageRequest {
		public typealias Message = DockRectAndEstimatedEdgeMessage

		/// The index of the screen to evaluate.
		public let screenIndex: Int

		/// - Parameters:
		///   - screenIndex: The index of the screen to evaluate.
		public init(screenIndex: Int) {
			self.screenIndex = screenIndex
		}
	}
}

// MARK: - Response

public extension DockRectAndEstimatedEdgeMessage {
	struct Response: XPCMessageResponse {
		public typealias Message = DockRectAndEstimatedEdgeMessage
		public typealias Result = Swift.Result<Self, Failure>

		/// The screen rect of the dock.
		public let rect: CGRect

		/// The edge of the screen that the dock lies on.
		public let edge: DockEdge

		/// - Parameters:
		///   - rect: The screen rect of the dock.
		///   - edge: The edge of the screen that the dock lies on.
		public init(
			rect: CGRect,
			edge: DockEdge
		) {
			self.rect = rect
			self.edge = edge
		}
	}
}
