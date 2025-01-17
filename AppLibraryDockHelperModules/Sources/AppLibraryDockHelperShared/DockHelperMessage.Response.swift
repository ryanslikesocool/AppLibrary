public extension DockHelperMessage {
	enum Response {
		case dockTileRect(DockHelperMessage.DockTileRect.Response)
		case dockEstimatedEdge(DockHelperMessage.DockEstimatedEdge.Response)
		case dockRectAndEstimatedEdge(DockHelperMessage.DockRectAndEstimatedEdge.Response)
	}
}

// MARK: - Codable

extension DockHelperMessage.Response: Codable { }
