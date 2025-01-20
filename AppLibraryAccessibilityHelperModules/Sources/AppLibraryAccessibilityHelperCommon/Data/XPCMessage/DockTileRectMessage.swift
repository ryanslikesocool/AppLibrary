import AppLibraryExtensionCommon
import CoreGraphics
import Foundation

public struct DockTileRectMessage: AccessibilityHelperMessageProtocol {
	public init() { }
}

// MARK: - Request

public extension DockTileRectMessage {
	struct Request: XPCMessageRequest {
		public typealias Message = DockTileRectMessage

		/// The bundle URL of the dock tile to locate.
		public let bundleURL: URL

		/// - Parameters:
		///   - bundleURL: The bundle URL of the dock tile to locate.
		public init(bundleURL: URL) {
			self.bundleURL = bundleURL
		}
	}
}

// MARK: - Response

public extension DockTileRectMessage {
	struct Response: XPCMessageResponse {
		public typealias Message = DockTileRectMessage
		public typealias Result = Swift.Result<Self, Failure>

		/// The screen rect of the dock tile.
		public let rect: CGRect

		/// - Parameters:
		///   - rect: The screen rect of the dock tile.
		public init(rect: CGRect) {
			self.rect = rect
		}
	}
}
