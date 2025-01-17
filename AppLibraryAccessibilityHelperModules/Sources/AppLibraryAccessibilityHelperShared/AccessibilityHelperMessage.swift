import AppLibraryExtensionCommon
import CoreGraphics
import Foundation

public enum AccessibilityHelperMessage {
//	case dockTileRect(DockTileRectMessage)
//	case dockEstimatedEdge(DockEstimatedEdgeMessage)
//	case dockRectAndEstimatedEdge(DockRectAndEstimatedEdgeMessage)
//	case requestAccessibilityAccess(RequestAccessibilityAccessMessage)
}

// MARK: - Codable

// extension AccessibilityHelperMessage: Codable { }

extension AccessibilityHelperMessage {
	enum CodingKeys: CodingKey {
		case dockTileRect
		case dockEstimatedEdge
		case dockRectAndEstimatedEdge
		case requestAccessibilityAccess
	}
}

// MARK: -

public extension AccessibilityHelperMessage {
	typealias Failure = AccessibilityHelperMessageError

	typealias DockTileRect = DockTileRectMessage
	typealias DockEstimatedEdge = DockEstimatedEdgeMessage
	typealias DockRectAndEstimatedEdge = DockRectAndEstimatedEdgeMessage
	typealias RequestAccessibilityAccess = RequestAccessibilityAccessMessage
}
