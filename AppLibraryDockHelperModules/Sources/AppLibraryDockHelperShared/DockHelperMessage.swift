import AppLibraryExtensionCommon
import CoreGraphics
import Foundation

public enum DockHelperMessage {
//	case dockTileRect(DockHelperMessage.DockTileRect.Message)
//	case dockEstimatedEdge(DockHelperMessage.DockEstimatedEdge.Message)
//	case dockRectAndEstimatedEdge(DockHelperMessage.DockRectAndEstimatedEdge.Message)
}

// MARK: - Codable

//extension DockHelperMessage: Codable { }

// MARK: - Supporting Data

public extension DockHelperMessage {
	enum DockTileRect: XPCMessageProtocol {
		public struct Request: Codable {
			/// The bundle URL of the dock tile.
			public let bundleURL: URL

			/// - Parameters:
			///   - bundleURL: The bundle URL of the dock tile.
			public init(bundleURL: URL) {
				self.bundleURL = bundleURL
			}
		}

		public struct Response: Codable {
			/// The screen rect of the dock tile.
			public let rect: CGRect

			/// - Parameters:
			///   - rect: The screen rect of the dock tile.
			public init(rect: CGRect) {
				self.rect = rect
			}
		}
	}

	enum DockEstimatedEdge: XPCMessageProtocol {
		public struct Request: Codable {
			/// The index of the screen to evaluate.
			public let screenIndex: Int

			/// - Parameters:
			///   - screenIndex: The index of the screen to evaluate.
			public init(screenIndex: Int) {
				self.screenIndex = screenIndex
			}
		}

		public struct Response: Codable {
			/// The edge of the screen that the dock lies on.
			public let edge: DockEdge

			/// - Parameters:
			///   - edge: The edge of the screen that the dock lies on.
			public init(edge: DockEdge) {
				self.edge = edge
			}
		}
	}

	enum DockRectAndEstimatedEdge: XPCMessageProtocol {
		public struct Request: Codable {
			/// The index of the screen to evaluate.
			public let screenIndex: Int

			/// - Parameters:
			///   - screenIndex: The index of the screen to evaluate.
			public init(screenIndex: Int) {
				self.screenIndex = screenIndex
			}
		}

		public struct Response: Codable {
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
}
