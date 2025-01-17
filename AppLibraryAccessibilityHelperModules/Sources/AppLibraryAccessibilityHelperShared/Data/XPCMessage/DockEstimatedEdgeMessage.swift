import AppLibraryExtensionCommon
import CoreGraphics

public struct DockEstimatedEdgeMessage: XPCMessage {
	public typealias Super = AccessibilityHelperMessage
	public typealias Failure = Super.Failure

	public init() { }
}

// MARK: - Request

public extension DockEstimatedEdgeMessage {
	struct Request: XPCMessageRequest {
		public typealias Message = DockEstimatedEdgeMessage

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

public extension DockEstimatedEdgeMessage {
	struct Response: XPCMessageResponse {
		public typealias Message = DockEstimatedEdgeMessage
		public typealias Result = Swift.Result<Self, Failure>

		/// The edge of the screen that the dock lies on.
		public let edge: DockEdge

		/// - Parameters:
		///   - edge: The edge of the screen that the dock lies on.
		public init(edge: DockEdge) {
			self.edge = edge
		}
	}
}
