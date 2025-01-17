import AppLibraryExtensionCommon
@preconcurrency import XPC

public extension XPCSession {
	/// Establishes a connection to an XPC service with the name you specify.
	///
	/// - Parameters:
	///   - xpcService: The name of the XPC service to connect to.
	///   - targetQueue: The dispatch queue to use for session events.
	///   You can specify a concurrent dispatch queue.
	///   If you specify `nil`, the session uses `DISPATCH_TARGET_QUEUE_DEFAULT`.
	///   - options: Attributes the session uses when establishing the connection.
	///   - cancellationHandler: A closure the system calls when it cancels a session.
	convenience init(
		xpcService: borrowing XPCServiceName,
		targetQueue: DispatchQueue? = nil,
		options: XPCSession.InitializationOptions = XPCSession.InitializationOptions.none,
		cancellationHandler: ((XPCRichError) -> Void)? = nil
	) throws {
		try self.init(
			xpcService: xpcService.rawValue,
			targetQueue: targetQueue,
			options: options,
			cancellationHandler: cancellationHandler
		)
	}
}
