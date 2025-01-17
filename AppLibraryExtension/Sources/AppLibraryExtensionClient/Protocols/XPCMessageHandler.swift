import AppLibraryExtensionCommon
import XPC

public protocol XPCMessageHandler: XPCMessage, XPCPeerHandler where
	Input == Request
{
	init()

	func performTask(_ request: Request) throws(Failure) -> Response
}

// MARK: - Default Implementation

public extension XPCMessageHandler where
	Failure == Never,
	Output == Response
{
	func handleIncomingRequest(_ request: Input) -> Response? {
		performTask(request)
	}
}

public extension XPCMessageHandler where
	Output == Result<Response, Failure>
{
	func handleIncomingRequest(_ request: Input) -> Result<Response, Failure>? {
		do {
			return try .success(performTask(request))
		} catch {
			return .failure(error)
		}
	}
}
