import AppLibraryCore
import AppLibraryExtensionCommon
import XPC

public extension XPCListener.IncomingSessionRequest {
	/// Accepts an incoming session request from a client using closures to handle encodable messages or cancellation.
	///
	/// - Parameters:
	///   - incomingMessageHandler: A closure that receives incoming messages from a client.
	///   - cancellationHandler: An optional closure that the system invokes when it cancels the session.
	/// - Returns: A decision that indicates whether the listener accepts or rejects the incoming session.
	// NOTE: This function is disfavored over the function that receives an `incomingMessageHandler` that returns `(any Encodable)?`.
	@_disfavoredOverload
	func accept<Request>(
		incomingMessageHandler: @escaping (Request) throws(Request.Failure) -> (Request.Response),
		cancellationHandler: ((XPCRichError) -> Void)? = nil
	) -> XPCListener.IncomingSessionRequest.Decision where
		Request: XPCMessageRequest,
		Request.Message: XPCMessageHandler,
		Request.Message.Input == Request,
		Request.Message.Output == Swift.Result<Request.Response, Request.Failure>
	{
		accept(
			incomingMessageHandler: { (request: Request) -> (any Encodable)? in
				Request.Message().handleIncomingRequest(request)
			},
			cancellationHandler: cancellationHandler
		)
	}

	/// Accepts an incoming session request from a client using closures to handle encodable messages or cancellation, and returns the inactive session.
	///
	/// - Parameters:
	///   - incomingMessageHandler: A closure that receives incoming messages from a client.
	///   - cancellationHandler: An optional closure that the system invokes when it cancels the session.
	/// - Returns: A tuple that indicates whether the listener accepts or rejects the incoming session, and the inactive session.
	// NOTE: This function is disfavored over the function that receives an `incomingMessageHandler` that returns `(any Encodable)?`.
	@_disfavoredOverload
	func accept<Request>(
		incomingMessageHandler: @escaping (Request) throws(Request.Failure) -> (Request.Response),
		cancellationHandler: ((XPCRichError) -> Void)? = nil
	) -> (XPCListener.IncomingSessionRequest.Decision, XPCSession) where
		Request: XPCMessageRequest,
		Request.Message: XPCMessageHandler,
		Request.Message.Input == Request,
		Request.Message.Output == Swift.Result<Request.Response, Request.Failure>
	{
		accept(
			incomingMessageHandler: { (request: Request) -> (any Encodable)? in
				Request.Message().handleIncomingRequest(request)
			},
			cancellationHandler: cancellationHandler
		)
	}

	/// Accepts an incoming session request from a client using closures to handle encodable messages or cancellation.
	///
	/// - Parameters:
	///   - incomingMessageHandler: A closure that receives incoming messages from a client.
	///   - cancellationHandler: An optional closure that the system invokes when it cancels the session.
	/// - Returns: A decision that indicates whether the listener accepts or rejects the incoming session.
	// NOTE: This function is disfavored over the function that receives an `incomingMessageHandler` that returns `(any Encodable)?`.
	@_disfavoredOverload
	func accept<Request>(
		incomingMessageHandler: @escaping (Request) -> (Request.Response),
		cancellationHandler: ((XPCRichError) -> Void)? = nil
	) -> XPCListener.IncomingSessionRequest.Decision where
		Request: XPCMessageRequest,
		Request.Message: XPCMessageHandler,
		Request.Message.Input == Request,
		Request.Message.Output == Request.Response,
		Request.Failure == Never
	{
		accept(
			incomingMessageHandler: { (request: Request) -> (any Encodable)? in
				Request.Message().handleIncomingRequest(request)
			},
			cancellationHandler: cancellationHandler
		)
	}

	/// Accepts an incoming session request from a client using closures to handle encodable messages or cancellation, and returns the inactive session.
	///
	/// - Parameters:
	///   - incomingMessageHandler: A closure that receives incoming messages from a client.
	///   - cancellationHandler: An optional closure that the system invokes when it cancels the session.
	/// - Returns: A tuple that indicates whether the listener accepts or rejects the incoming session, and the inactive session.
	// NOTE: This function is disfavored over the function that receives an `incomingMessageHandler` that returns `(any Encodable)?`.
	@_disfavoredOverload
	func accept<Request>(
		incomingMessageHandler: @escaping (Request) -> (Request.Response),
		cancellationHandler: ((XPCRichError) -> Void)? = nil
	) -> (XPCListener.IncomingSessionRequest.Decision, XPCSession) where
		Request: XPCMessageRequest,
		Request.Message: XPCMessageHandler,
		Request.Message.Input == Request,
		Request.Message.Output == Request.Response,
		Request.Failure == Never
	{
		accept(
			incomingMessageHandler: { (request: Request) -> (any Encodable)? in
				Request.Message().handleIncomingRequest(request)
			},
			cancellationHandler: cancellationHandler
		)
	}
}
