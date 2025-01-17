import AppLibraryExtensionCommon
@preconcurrency import XPC

public protocol AppLibraryXPCClientProtocol {
	static var xpcServiceName: XPCServiceName { get }
	static var targetQueue: DispatchQueue? { get }
	static var options: XPCListener.InitializationOptions { get }

	var listener: XPCListener? { get set }

	init()

	func handleSession(
		request: XPCListener.IncomingSessionRequest
	) -> XPCListener.IncomingSessionRequest.Decision
}

// MARK: - Intrinsic

public extension AppLibraryXPCClientProtocol {
	// Set up the listener and start listening for connections.
	static func main() throws {
		var instance = Self()

		instance.listener = try XPCListener(
			xpcService: Self.xpcServiceName,
			targetQueue: Self.targetQueue,
			options: Self.options,
			incomingSessionHandler: instance.handleSession(request:)
		)

		// Start the main dispatch queue to begin processing messages.
		dispatchMain()
	}
}

// MARK: - Default Implementation

public extension AppLibraryXPCClientProtocol {
	static var targetQueue: DispatchQueue? { nil }
	static var options: XPCListener.InitializationOptions { .none }
}