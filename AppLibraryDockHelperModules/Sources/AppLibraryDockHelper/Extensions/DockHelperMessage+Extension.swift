import AppKit
import AppLibraryDockHelperShared
import CoreGraphics

extension DockHelperMessage.Request {
	func performTask() throws -> DockHelperMessage.Response {
		switch self {
			case let .dockTileRect(request):
				try DockHelperMessage.Response.dockTileRect(
					DockHelperMessage.DockTileRect.performTask(request)
				)
			case let .dockEstimatedEdge(request):
				try DockHelperMessage.Response.dockEstimatedEdge(
					DockHelperMessage.DockEstimatedEdge.performTask(request)
				)
			case let .dockRectAndEstimatedEdge(request):
				try DockHelperMessage.Response.dockRectAndEstimatedEdge(
					DockHelperMessage.DockRectAndEstimatedEdge.performTask(request)
				)
		}
	}
}

extension DockHelperMessage.DockTileRect {
	static func performTask(_ request: Request) throws -> Response {
		guard let rect = Dock.main?.applicationTile(withURL: request.bundleURL)?.rect else {
			throw DockHelperMessageError.unexpectedNil
		}
		return Response(rect: rect)
	}
}

extension DockHelperMessage.DockEstimatedEdge {
	static func performTask(_ request: Request) throws -> Response {
		guard let edge = Dock.main?.estimatedEdge(on: NSScreen.screens[request.screenIndex]) else {
			throw DockHelperMessageError.unexpectedNil
		}
		return Response(edge: edge)
	}
}

extension DockHelperMessage.DockRectAndEstimatedEdge {
	static func performTask(_ request: Request) throws -> Response {
		guard let (rect, edge) = Dock.main?.rectAndEstimatedEdge(on: NSScreen.screens[request.screenIndex]) else {
			throw DockHelperMessageError.unexpectedNil
		}
		return Response(rect: rect, edge: edge)
	}
}
