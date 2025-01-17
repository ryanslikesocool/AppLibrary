import Foundation

public extension PropertyListEncoder {
	func with(
		outputFormat: PropertyListSerialization.PropertyListFormat
	) -> Self {
		self.outputFormat = outputFormat
		return self
	}
}