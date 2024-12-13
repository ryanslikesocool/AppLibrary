import Foundation

extension PropertyListEncoder {
	static let shared: PropertyListEncoder = {
		let encoder = PropertyListEncoder()
		encoder.outputFormat = .binary
		return encoder
	}()
}