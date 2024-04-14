import AppKit
import SerializationKit

public extension AppSettings {
	struct Display {
		public var appearance: Appearance
		public var reduceMotion: Bool
		public var reduceTransparency: Bool

		init() {
			appearance = .system
			reduceMotion = false
			reduceTransparency = false
		}
	}
}

// MARK: - Sendable

extension AppSettings.Display: Sendable { }

// MARK: - Equatable

extension AppSettings.Display: Equatable { }

// MARK: - Hashable

extension AppSettings.Display: Hashable { }

// MARK: - Codable

extension AppSettings.Display: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let defaultSettings: Self = Self()

		appearance = try container.decodeIfPresent(forKey: .appearance) ?? defaultSettings.appearance
		reduceMotion = try container.decodeIfPresent(forKey: .reduceMotion) ?? defaultSettings.reduceMotion
		reduceTransparency = try container.decodeIfPresent(forKey: .reduceTransparency) ?? defaultSettings.reduceTransparency
	}
}

// MARK: - Settings File

extension AppSettings.Display: SettingsFile {
	public static var fileName: String { "display.plist" }

	public mutating func prepare() {
		NSApp.appearance = appearance.nsApperance
	}
}
