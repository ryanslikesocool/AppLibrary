import AppLibraryExtensionCommon
@preconcurrency import XPC

public protocol AppLibraryXPCServerProtocol: AnyObject {
	/// The name of the service.
	static var serviceName: XPCServiceName { get }

	static var targetQueue: DispatchQueue? { get }

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