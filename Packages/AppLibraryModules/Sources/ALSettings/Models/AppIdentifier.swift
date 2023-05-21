import Foundation
import LoveCore

public struct AppIdentifier: Identifiable, Hashable, Codable, CustomStringConvertible {
	public let id: UUID = UUID()

	public var url: URL
	public var isHidden: Bool = false

	public init(url: URL) {
		self.url = url
	}

	public var pathExtension: String { url.pathExtension }
	public var description: String { url.lastPathComponent.deletingSuffix(".app") }

	private enum CodingKeys: CodingKey {
		case url
		case isHidden
	}
}
