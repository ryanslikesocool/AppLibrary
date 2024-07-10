import Foundation

public extension PropertyListEncoder {
	static let shared: PropertyListEncoder = PropertyListEncoder()

	func with(outputFormat: PropertyListSerialization.PropertyListFormat) -> Self {
		self.outputFormat = outputFormat
		return self
	}
}
