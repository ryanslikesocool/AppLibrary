// TODO: Replace with or implement `XPCPeerHandler`

public protocol XPCMessageProtocol {
	associatedtype Request: Codable
	associatedtype Response: Codable

	typealias Message = XPCMessage<Request, Response>
}