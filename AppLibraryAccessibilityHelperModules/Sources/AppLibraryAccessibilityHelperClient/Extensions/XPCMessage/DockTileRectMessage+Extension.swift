import AppLibraryAccessibilityHelperCommon
import AppLibraryExtensionClient
import AppLibraryExtensionCommon

extension DockTileRectMessage: XPCMessageHandler {
	public typealias Input = Request
	public typealias Output = Result<Response, Failure>

	public func performTask(_ request: Request) throws(Failure) -> Response {
		guard let dock = Dock.main else {
			throw .missingDock
		}

		guard let dockTile = dock.applicationTile(withURL: request.bundleURL) else {
			throw .missingDockTile(request.bundleURL)
		}

		guard let rect = dockTile.rect else {
			throw .unexpectedNil
		}

		return Response(rect: rect)
	}
}
