public enum XPCMessage<Request, Response> where
	Request: Codable,
	Response: Codable
{
	case request(Request)
	case response(Response)
}

// MARK: - Sendable

extension XPCMessage: Sendable where Request: Sendable, Response: Sendable { }

// MARK: - Equatable

extension XPCMessage: Equatable where Request: Equatable, Response: Equatable { }

// MARK: - Hashable

extension XPCMessage: Hashable where Request: Hashable, Response: Hashable { }

// MARK: - Codable

extension XPCMessage: Codable { }
