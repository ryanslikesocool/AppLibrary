import Foundation

public extension JSONEncoder {
	static let shared: JSONEncoder = {
		let encoder = JSONEncoder()
#if DEBUG
		encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
#endif
		return encoder
	}()
}

public extension PropertyListEncoder {
	static let shared: PropertyListEncoder = {
		let encoder = PropertyListEncoder()
		encoder.outputFormat = .binary
		return encoder
	}()
}