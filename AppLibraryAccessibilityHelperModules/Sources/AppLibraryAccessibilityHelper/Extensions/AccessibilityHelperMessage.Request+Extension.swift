import AppLibraryAccessibilityHelperShared

extension AccessibilityHelperMessage.Request {
	func performTask() throws -> AccessibilityHelperMessage.Response {
		typealias Message = AccessibilityHelperMessage
		typealias Response = Message.Response

		switch self {
			case let .dockTileRect(request):
//				return try Response.dockTileRect(
//					Message.DockTileRect.performTask(request)
//				)

				guard let response = Message.DockTileRect().handleIncomingRequest(request) else {
					throw AccessibilityHelperMessageError.unexpectedNil
				}
				return Response.dockTileRect(response)
			case let .dockEstimatedEdge(request):
//				return try Response.dockEstimatedEdge(
//					Message.DockEstimatedEdge.performTask(request)
//				)

				guard let response = Message.DockEstimatedEdge().handleIncomingRequest(request) else {
					throw AccessibilityHelperMessageError.unexpectedNil
				}
				return Response.dockEstimatedEdge(response)
			case let .dockRectAndEstimatedEdge(request):
//				return try Response.dockRectAndEstimatedEdge(
//					Message.DockRectAndEstimatedEdge.performTask(request)
//				)

				guard let response = Message.DockRectAndEstimatedEdge().handleIncomingRequest(request) else {
					throw AccessibilityHelperMessageError.unexpectedNil
				}
				return Response.dockRectAndEstimatedEdge(response)
			case let .requestAccessibilityAccess(request):
//				return try Response.requestAccessibilityAccess(
//					Message.RequestAccessibilityAccess.performTask(request)
//				)

				guard let response = Message.RequestAccessibilityAccess().handleIncomingRequest(request) else {
					throw AccessibilityHelperMessageError.unexpectedNil
				}
				return Response.requestAccessibilityAccess(response)
		}
	}
}
