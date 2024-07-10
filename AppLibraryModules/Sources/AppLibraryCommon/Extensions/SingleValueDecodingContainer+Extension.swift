import Foundation

public extension SingleValueDecodingContainer {
	func decode<T: Decodable>() throws -> T {
		try decode(T.self)
	}
}
