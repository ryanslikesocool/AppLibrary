import Foundation
import SerializationKit

public final class AppSettings: ObservableObject, PlistCodable {
	public static let format: PropertyListSerialization.PropertyListFormat = .xml
	public static let shared: AppSettings = AppSettings.load()

	@Published public var general: General = General()
	@Published public var appDirectories: AppDirectories = AppDirectories()

	// var columns: Int = 3 { didSet { Self.set(columns, for: .columns) } }
	// var sizeClass: Int = 2 { didSet { Self.set(sizeClass, for: .sizeClass) } }
	// var spacing: Double = 36.0 { didSet { Self.set(spacing, for: .spacing) } }
	// var padding: Double = 24.0 { didSet { Self.set(padding, for: .padding) } }
	// var iconSize: Double { Double(sizeClass) * 32.0 }

	private init() { }

	// MARK: - Codable

	private enum CodingKeys: String, CodingKey {
		case general
		case appDirectories
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		general = try container.decode(General.self, forKey: .general)
		appDirectories = try container.decode(AppDirectories.self, forKey: .appDirectories)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(general, forKey: .general)
		try container.encode(appDirectories, forKey: .appDirectories)
	}
}

// MARK: - Hashable

extension AppSettings: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(general)
		hasher.combine(appDirectories)
	}

	public static func == (lhs: AppSettings, rhs: AppSettings) -> Bool {
		lhs.hashValue == rhs.hashValue
	}
}

// MARK: - SerializedFileConvertible

extension AppSettings: SerializedFileConvertible {
	static var fileURL: URL { URL.applicationSupportDirectory.appendingPathComponent("LoveTexture/Settings.plist", isDirectory: false) }

	public func save() {
		save(to: AppSettings.fileURL)
	}

	private static func load() -> AppSettings {
		AppSettings(url: fileURL) ?? AppSettings()
	}
}
