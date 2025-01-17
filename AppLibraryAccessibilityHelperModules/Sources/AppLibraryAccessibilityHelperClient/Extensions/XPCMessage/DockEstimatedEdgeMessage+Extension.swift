import AppKit
import AppLibraryAccessibilityHelperCommon
import AppLibraryExtensionClient

extension DockEstimatedEdgeMessage: XPCMessageHandler {
	public typealias Input = Request
	public typealias Output = Result<Response, Failure>

	public func performTask(_ request: Request) throws(Failure) -> Response {
		guard let dock = Dock.main else {
			throw AccessibilityHelperMessageError.missingDock
		}

		let screens = NSScreen.screens
		assert(screens.count > request.screenIndex)
		let screen = screens[request.screenIndex]

		guard let edge = dock.estimatedEdge(on: screen) else {
			throw AccessibilityHelperMessageError.unexpectedNil
		}

		return Response(edge: edge)
	}
}
