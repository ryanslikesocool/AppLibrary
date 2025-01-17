public protocol XPCMessageResponse: Codable {
	associatedtype Message: XPCMessage where Message.Response == Self

	typealias Failure = Message.Failure

	typealias Request = Message.Request
}
