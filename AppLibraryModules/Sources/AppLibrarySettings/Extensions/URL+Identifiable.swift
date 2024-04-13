import Foundation

extension URL: Identifiable {
	public var id: String { path(percentEncoded: false) }
}
