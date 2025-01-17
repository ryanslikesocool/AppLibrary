public protocol XPCMessage {
	associatedtype Failure: Error & Codable = Never

	associatedtype Request: XPCMessageRequest where Request.Message == Self
	associatedtype Response: XPCMessageResponse where Response.Message == Self

	associatedtype Output
}

// MARK: - Default Implementation

public extension XPCMessage where
	Failure == Never
{
	typealias Output = Response
}

public extension XPCMessage {
	typealias Output = Swift.Result<Response, Failure>
}