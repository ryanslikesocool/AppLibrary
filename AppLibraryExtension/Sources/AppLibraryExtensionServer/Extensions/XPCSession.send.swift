import AppLibraryExtensionCommon
import XPC

public extension XPCSession {
	/// Sends an encodable `request` asynchronously over the session to the destination service.
	///
	/// - Parameters:
	///   - isolation: The actor isolation used to send the message.
	///   The current
	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
	///   is used by default.
	///   - request: An encodable object that contains the request to send.
	/// - Returns: If successful, the response to the `request`; otherwise this method throws an error.
	// NOTE: This function is disfavored over the function that receives `Message: Encodable`.
//	@_disfavoredOverload
	func send<Request>(
		isolation: isolated (any Actor)? = #isolation,
		request: Request
	) async throws -> Request.Response where
		Request: XPCMessageRequest,
		Request.Response: Sendable, // TODO: `Sendable` should not be a requirement here.
		Request.Message.Output == Result<Request.Response, Request.Failure>
	{
		let result: Request.Message.Output = try await send(isolation: isolation, request)

		switch result {
			case let .success(success): return success
			case let .failure(failure): throw failure
		}
	}

	/// Sends an encodable `request` asynchronously over the session to the destination service.
	///
	/// - Parameters:
	///   - isolation: The actor isolation used to send the message.
	///   The current
	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
	///   is used by default.
	///   - request: An encodable object that contains the request to send.
	/// - Returns: If successful, the response to the `request`; otherwise this method throws an error.
	// NOTE: This function is disfavored over the function that receives `Message: Encodable`.
//	@_disfavoredOverload
	func send<Request>(
		isolation: isolated (any Actor)? = #isolation,
		request: Request
	) async throws -> Request.Response where
		Request: XPCMessageRequest,
		Request.Response: Sendable, // TODO: `Sendable` should not be a requirement here.
		Request.Failure == Never
	{
		try await send(isolation: isolation, request)
	}

	/// Sends an encodable `message` asynchronously over the session to the destination service.
	///
	/// - Parameters:
	///   - isolation: The actor isolation used to send the message.
	///   The current
	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
	///   is used by default.
	///   - message: An encodable object that contains the message to send.
	/// - Returns: If successful, the response to the `message`; otherwise this method throws an error.
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

	/// Sends a message asynchronously over the session to the destination service.
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

//	/// Sends an encodable `message` asynchronously over the session to the destination service.
//	///
//	/// - Parameters:
//	///   - isolation: The actor isolation used to send the message.
//	///   The current
//	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
//	///   is used by default.
//	///   - message: An encodable object that contains the message to send.
//	/// - Returns: If successful, the response to the `message`; otherwise this method throws an error.
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

//	/// Sends a `message` asynchronously over the session to the destination service.
//	///
//	/// - Parameters:
//	///   - isolation: The actor isolation used to send the message.
//	///   The current
//	///   [`#isolation`]( https://developer.apple.com/documentation/swift/isolation() )
//	///   is used by default.
//	///   - message: A dictionary object that contains the message to send.
//	/// - Returns: If successful, the response to the `message`; otherwise this method throws an error.
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
