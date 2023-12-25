import AppKit
import SerializationKit

public extension AppSettings {
	struct Display {
		public var appearance: Appearance
		public var appView: AppViewMode
		public var autoGroup: Bool

		init() {
			appearance = .system
			appView = .list
			autoGroup = true
		}
	}
}

// MARK: - Hashable

extension AppSettings.Display: Hashable { }

// MARK: - Codable

extension AppSettings.Display: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let defaultSettings: Self = Self()

		appearance = try container.decodeIfPresent(forKey: .appearance) ?? defaultSettings.appearance
		appView = try container.decodeIfPresent(forKey: .appView) ?? defaultSettings.appView
		autoGroup = try container.decodeIfPresent(forKey: .autoGroup) ?? defaultSettings.autoGroup
	}
}

// MARK: - Settings File

extension AppSettings.Display: SettingsFile {
	public static let fileName: String = "display.plist"

	public mutating func prepare() {
		NSApp.appearance = appearance.nsApperance
		if appView == .list {
			autoGroup = false
		}
	}
}
