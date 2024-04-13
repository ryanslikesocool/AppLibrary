import AppLibraryCommon
import OSLog
import SerializationKit

public extension AppSettings {
	struct Apps {
		public private(set) var hiddenApps: Set<ApplicationIdentifier>

		init() {
			hiddenApps = Self.defaultHiddenApps
		}
	}
}

// MARK: - Sendable

extension AppSettings.Apps: Sendable { }

// MARK: - Equatable

extension AppSettings.Apps: Equatable { }

// MARK: - Hashable

extension AppSettings.Apps: Hashable { }

// MARK: - Codable

extension AppSettings.Apps: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let defaultSettings: Self = Self()

		hiddenApps = try container.decodeIfPresent(forKey: .hiddenApps) ?? defaultSettings.hiddenApps
	}
}

// MARK: - SettingsFile

extension AppSettings.Apps: SettingsFile {
	public static var fileName: String { "apps.plist" }
}

// MARK: - Constants

extension AppSettings.Apps {
	static var defaultHiddenApps: Set<ApplicationIdentifier> { [
		ApplicationIdentifier(AppLibraryInformation.bundleIdentifier, named: "App Library"),
	] }
}

// MARK: -

public extension AppSettings.Apps {
	mutating func tryAddHiddenApp(withIdentifier appIdentifier: ApplicationIdentifier) {
		if hiddenApps.insert(appIdentifier).inserted {
			Logger.module.debug("Successfully added hidden app with identifier \"\(appIdentifier.bundleIdentifier)\".")
		}
	}

	mutating func removeHiddenApp(withIdentifier appIdentifier: ApplicationIdentifier) {
		if hiddenApps.remove(appIdentifier) != nil {
			Logger.module.debug("Successfully removed hidden app with identifier \"\(appIdentifier.bundleIdentifier)\"")
		}
	}
}
