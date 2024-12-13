import Foundation

public extension JSONDecoder {
	static let shared: JSONDecoder = JSONDecoder()
}

public extension PropertyListDecoder {
	static let shared: PropertyListDecoder = PropertyListDecoder()
}