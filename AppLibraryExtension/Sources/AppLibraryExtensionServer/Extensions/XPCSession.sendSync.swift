import AppLibraryCore
import AppLibraryExtensionCommon
import XPC

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
}
