import AppLibraryCore
import AppLibraryExtensionCommon
import XPC
import XPCToolbox

// MARK: - send

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
}

// MARK: - sendSync

public extension XPCSession {
	/// Sends a `request` over the session to the destination service, blocking the caller until receiving an encodable reply message.
	///
	/// - Parameter request: An encodable object that contains the message to send.
	/// - Returns: If successful, the response to the `request`; otherwise this method throws an error.
	// NOTE: This function is disfavored over the function that receives `Message: Encodable`.
//	@_disfavoredOverload
	func sendSync<Request>(
		request: Request
	) throws -> Request.Response where
		Request: XPCMessageRequest,
		Request.Message.Output == Result<Request.Response, Request.Failure>
	{
		let result: Request.Message.Output = try sendSync(request)

		switch result {
			case let .success(success): return success
			case let .failure(failure): throw failure
		}
	}

	/// Sends a `request` over the session to the destination service, blocking the caller until receiving an encodable reply message.
	///
	/// - Parameter request: An encodable object that contains the message to send.
	/// - Returns: If successful, the response to the `request`; otherwise this method throws an error.
	// NOTE: This function is disfavored over the function that receives `Message: Encodable`.
//	@_disfavoredOverload
	func sendSync<Request>(
		request: Request
	) throws -> Request.Response where
		Request: XPCMessageRequest,
		Request.Failure == Never
	{
		try sendSync(request)
	}

//	func sendSync<Message>(
//		_ messageRequest: Message.Request,
//		ofType messageType: Message.Type
//	) throws -> Message.Response where
//		Message: XPCMessageProtocol
//	{
//		try sendSync(messageRequest)
//	}
}
