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
		xpcService: XPCServiceName,
		targetQueue: DispatchQueue? = nil,
		options: XPCSession.InitializationOptions = .none,
		cancellationHandler: ((XPCRichError) -> Void)? = nil
	) throws {
		try self.init(
			xpcService: xpcService.rawValue,
			targetQueue: targetQueue,
			options: options,
			cancellationHandler: cancellationHandler
		)
	}

//	func sendSync<Request, Response>(
//		_ request: Request
//	) throws -> Response where
//		Request: Codable,
//		Response: Codable
//	{
//		typealias Message = XPCMessage<Request, Response>
//
//		try sendSync()
//	}

//	func sendSync<Message>(
//		_ messageRequest: Message.Request,
//		ofType messageType: Message.Type
//	) throws -> Message.Response where
//		Message: XPCMessageProtocol
//	{
//		try sendSync(messageRequest)
//	}

	/// Sends a message over the session to the destination service, blocking the caller until receiving an encodable reply message.
	///
	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
	func sendSync<Reply>() throws -> Reply where
		Reply: Decodable
	{
		let message: UInt8 = UInt8.min
		return try sendSync(message)
	}

	/// Sends a message over the session to the destination service, blocking the caller until receiving an encodable reply message.
	///
	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
	func sendSync() throws -> XPCReceivedMessage {
		let message: UInt8 = UInt8.min
		return try sendSync(message)
	}

	/// Sends a message over the session to the destination service, blocking the caller until receiving a reply.
	///
	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
	func sendSync() throws -> XPCDictionary {
		let message = XPCDictionary()
		return try sendSync(message: message)
	}

	/// Sends an encodable message over the session to the destination service.
	///
	/// - Parameters:
	///   - isolation: The actor isolation used to send the message.
	///   The current
	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
	///   is used by default.
	///   - message: An encodable object that contains the message to send.
	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
	func send<Message, Reply>(
		isolation: isolated (any Actor)? = #isolation,
		_ message: Message
	) async throws -> Reply where
		Message: Encodable,
		Reply: Decodable & Sendable // TODO: `Sendable` should not be a requirement here.
	{
		try await withCheckedThrowingContinuation(
			isolation: isolation
		) { continuation in
			do {
				try self.send(message) { (result: Result<Reply, any Error>) in
					continuation.resume(with: result)
				}
			} catch {
				continuation.resume(throwing: error)
			}
		}
	}

	/// Sends a message over the session to the destination service.
	///
	/// - Parameter isolation: The actor isolation used to send the message.
	///   The current
	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
	///   is used by default.
	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
	func send<Reply>(
		isolation: isolated (any Actor)? = #isolation
	) async throws -> Reply where
		Reply: Decodable & Sendable // TODO: `Sendable` should not be a requirement here.
	{
		let message: UInt8 = UInt8.min
		return try await send(isolation: isolation, message)
	}

//	/// Sends an encodable message asynchronously over the session to the destination service.
//	///
//	/// - Parameters:
//	///   - isolation: The actor isolation used to send the message.
//	///   The current
//	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
//	///   is used by default.
//	///   - message: An encodable object that contains the message to send.
//	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
//	func send<Message>(
//		isolation: isolated (any Actor)? = #isolation,
//		_ message: Message
//	) async throws -> XPCReceivedMessage where
//		Message: Encodable
//	{
//		try await withCheckedThrowingContinuation(
//			isolation: isolation
//		) { continuation in
//			do {
//				try self.send(message) { (result: Result<XPCReceivedMessage, XPCRichError>) in
//					continuation.resume(with: result)
//				}
//			} catch {
//				continuation.resume(throwing: error)
//			}
//		}
//	}

//	/// Sends a message asynchronously over the session to the destination service.
//	///
//	/// - Parameter isolation: The actor isolation used to send the message.
//	///   The current
//	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
//	///   is used by default.
//	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
//	func send(
//		isolation: isolated (any Actor)? = #isolation
//	) async throws -> XPCReceivedMessage {
//		let message: UInt8 = UInt8.min
//		return try await send(isolation: isolation, message)
//	}

//	/// Sends a message asynchronously over the session to the destination service.
//	///
//	/// - Parameters:
//	///   - isolation: The actor isolation used to send the message.
//	///   The current
//	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
//	///   is used by default.
//	///   - message: A dictionary object that contains the message to send.
//	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
//	func send(
//		isolation: isolated (any Actor)? = #isolation,
//		message: XPCDictionary
//	) async throws -> XPCDictionary {
//		try await withCheckedThrowingContinuation(
//			isolation: isolation
//		) { continuation in
//			self.send(message: message) { (result: Result<XPCDictionary, XPCRichError>) in
//				continuation.resume(with: result)
//			}
//		}
//	}

//	/// Sends a message asynchronously over the session to the destination service.
//	///
//	/// - Parameter isolation: The actor isolation used to send the message.
//	///   The current
//	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
//	///   is used by default.
//	/// - Returns: If successful, the response to the message; otherwise this method throws an error.
//	func send(
//		isolation: isolated (any Actor)? = #isolation
//	) async throws -> XPCDictionary {
//		let message = XPCDictionary()
//		return try await send(isolation: isolation, message: message)
//	}
}
