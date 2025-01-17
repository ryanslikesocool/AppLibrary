public protocol XPCMessageRequest: Codable {
	associatedtype Message: XPCMessage where Message.Request == Self

	typealias Failure = Message.Failure

	typealias Response = Message.Response
}
