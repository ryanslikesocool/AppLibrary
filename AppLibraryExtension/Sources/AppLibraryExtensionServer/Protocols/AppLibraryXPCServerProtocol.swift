import AppLibraryExtensionCommon
@preconcurrency import XPC
import XPCToolbox

public protocol AppLibraryXPCServerProtocol: AnyObject {
	/// The name of the XPC service to connect to.
	static var serviceName: XPCServiceName { get }

	/// The dispatch queue to use for session events.
	/// You can specify a concurrent dispatch queue.
	/// If you specify `nil`, the session uses `DISPATCH_TARGET_QUEUE_DEFAULT`.
	static var targetQueue: DispatchQueue? { get }

	/// Attributes the session uses when establishing the connection.
	static var options: XPCSession.InitializationOptions { get }

	var session: XPCSession { get }

//	func sendRequest() async throws

	func cancelled(with error: XPCRichError)

	consuming func complete()
}

// MARK: - Default Implementation

public extension AppLibraryXPCServerProtocol {
	static var targetQueue: DispatchQueue? { nil }
	static var options: XPCSession.InitializationOptions { .none }

	func cancelled(with error: XPCRichError) { }

	consuming func complete() {
		session.cancel(reason: "Session complete")
	}
}
