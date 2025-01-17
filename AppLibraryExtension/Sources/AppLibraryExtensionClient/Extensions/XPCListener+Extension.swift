import AppLibraryExtensionCommon
@preconcurrency import XPC

public extension XPCListener {
	/// - Parameters:
	///   - xpcService: The XPC service name that clients use to connect to the service.
	///   - targetQueue: The dispatch queue that events arrive on.
	///   This may be a concurrent queue.
	///   If `nil`, the listeners uses `DISPATCH_TARGET_QUEUE_DEFAULT`.
	///   - options: Configuration options for the listener, such as creating it in an inactive state.
	///   - incomingSessionHandler: A handler that the system calls when a client connects to the XPC service.
	convenience init(
		xpcService: XPCServiceName,
		targetQueue: DispatchQueue? = nil,
		options: XPCListener.InitializationOptions = .none,
		incomingSessionHandler: @escaping (XPCListener.IncomingSessionRequest) -> (XPCListener.IncomingSessionRequest.Decision)
	) throws {
		try self.init(
			service: xpcService.rawValue,
			targetQueue: targetQueue,
			options: options,
			incomingSessionHandler: incomingSessionHandler
		)
	}
}