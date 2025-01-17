import AppLibraryAccessibilityHelperCommon
import AppLibraryExtensionClient
import XPC

extension RequestAccessibilityAccessMessage: XPCMessageHandler {
	public typealias Input = Request
	public typealias Output = Result<Response, Failure>

	public func performTask(_ request: Request) throws(Failure) -> Response {
		let success = AccessibilityUtility.requestAccess()

		return Response(success: success)
	}
}
