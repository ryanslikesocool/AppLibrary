import AppLibraryCommon
import SerializationKit

public extension AppSettings {
	struct Apps {
		public private(set) var hiddenApps: [String]

		init() {
			hiddenApps = [
				AppLibraryInformation.bundleIdentifier,
			]
		}
	}
}

// MARK: - Hashable

extension AppSettings.Apps: Hashable { }

// MARK: - Codable

extension AppSettings.Apps: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let dflt: Self = Self()

		hiddenApps = try container.decodeIfPresent(forKey: .hiddenApps) ?? dflt.hiddenApps
	}
}

// MARK: - SettingsFile

extension AppSettings.Apps: SettingsFile {
	public static let fileName: String = "apps.plist"
}

// MARK: -

public extension AppSettings.Apps {
	mutating func tryAdd(hiddenApp: String) {
		if !hiddenApps.contains(hiddenApp) {
			hiddenApps.append(hiddenApp)
		}
	}

	mutating func removeHiddenApp(at index: Int) {
		hiddenApps.remove(at: index)
	}
}
