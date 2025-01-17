import Foundation

public extension DockHelperMessage {
	enum Request {
		case dockTileRect(DockHelperMessage.DockTileRect.Request)
		case dockEstimatedEdge(DockHelperMessage.DockEstimatedEdge.Request)
		case dockRectAndEstimatedEdge(DockHelperMessage.DockRectAndEstimatedEdge.Request)
	}
}

// MARK: - Codable

extension DockHelperMessage.Request: Codable { }

// MARK: - Convenience

public extension DockHelperMessage.Request {
	static func dockTileRect(bundleURL: URL) -> Self {
		dockTileRect(
			DockHelperMessage.DockTileRect.Request(bundleURL: bundleURL)
		)
	}

	static func dockEstimatedEdge(screenIndex: Int) -> Self {
		dockEstimatedEdge(
			DockHelperMessage.DockEstimatedEdge.Request(screenIndex: screenIndex)
		)
	}

	static func dockRectAndEstimatedEdge(screenIndex: Int) -> Self {
		dockRectAndEstimatedEdge(
			DockHelperMessage.DockRectAndEstimatedEdge.Request(screenIndex: screenIndex)
		)
	}
}
