import AppKit

public extension AppSettings {
	struct Display: Hashable {
		public var appearance: Appearance

		init() {
			appearance = .system
		}
	}
}

// MARK: - Codable

extension AppSettings.Display: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let defaultSettings: Self = Self()

		appearance = try container.decodeIfPresent(Appearance.self, forKey: .appearance) ?? defaultSettings.appearance
	}
}

// MARK: - Settings File

extension AppSettings.Display: SettingsFile {
	static let fileName: String = "display.plist"

	func prepare() {
		NSApp.appearance = appearance.nsApperance
	}
}
