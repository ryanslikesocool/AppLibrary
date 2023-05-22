import Foundation
import LoveCore

public extension AppSettings {
	struct General: Hashable, Codable {
		public var appearance: Appearance = .system

		public init() { }
	}
}
