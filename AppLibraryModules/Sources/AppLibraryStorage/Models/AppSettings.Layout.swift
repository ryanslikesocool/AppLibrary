import AppKit
import SerializationKit

public extension AppSettings {
	struct Layout {
		public var layout: LibraryLayout

		public var groupByCategory: Bool
		public var recentlyAddedGroup: Bool
		public var recentlyUpdatedGroup: Bool

		init() {
			layout = .list
			groupByCategory = true
			recentlyAddedGroup = true
			recentlyUpdatedGroup = true
		}
	}
}

// MARK: - Sendable

extension AppSettings.Layout: Sendable { }

// MARK: - Equatable

extension AppSettings.Layout: Equatable { }

// MARK: - Hashable

extension AppSettings.Layout: Hashable { }

// MARK: - Codable

extension AppSettings.Layout: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let defaultSettings: Self = Self()

		layout = try container.decodeIfPresent(forKey: .layout) ?? defaultSettings.layout
		groupByCategory = try container.decodeIfPresent(forKey: .groupByCategory) ?? defaultSettings.groupByCategory
		recentlyAddedGroup = try container.decodeIfPresent(forKey: .recentlyAddedGroup) ?? defaultSettings.recentlyAddedGroup
		recentlyUpdatedGroup = try container.decodeIfPresent(forKey: .recentlyUpdatedGroup) ?? defaultSettings.recentlyUpdatedGroup
	}
}

// MARK: - Settings File

extension AppSettings.Layout: SettingsFile {
	public static var fileName: String { "layout.plist" }
}
