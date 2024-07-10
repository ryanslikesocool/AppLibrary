import AppLibraryCommon
import OSLog

public final class AppsSettings {
	@Published public var applicationHideFlags: [ApplicationIdentifier: ApplicationHideFlags]

	public init() {
		applicationHideFlags = Constant.Settings.defaultApplicationVisibility
	}
}

// MARK: - Hashable

public extension AppsSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(applicationHideFlags)
	}
}

// MARK: - Codable

public extension AppsSettings {
	private enum CodingKeys: CodingKey {
		case applicationHideFlags
	}

	convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		applicationHideFlags = try container.decodeIfPresent(forKey: .applicationHideFlags) ?? applicationHideFlags
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(applicationHideFlags, forKey: .applicationHideFlags)
	}
}

// MARK: - SettingsFile

extension AppsSettings: SettingsFile {
	public static let shared: AppsSettings = .load()

	public static let category: SettingsCategory = .apps
}

// MARK: -

public extension AppsSettings {
	func hideApplication(with appIdentifier: ApplicationIdentifier) {
		var hideFlags = applicationHideFlags[appIdentifier] ?? .none
		let inserted = hideFlags.insert(.hiddenInBrowser).inserted
		applicationHideFlags[appIdentifier] = hideFlags

		if inserted {
			Logger.module.debug("Successfully added hidden app with identifier \"\(appIdentifier.bundleIdentifier)\".")
		}
	}

	func removeApplicationHideFlags(for appIdentifier: ApplicationIdentifier) {
		if applicationHideFlags.removeValue(forKey: appIdentifier) != nil {
			Logger.module.debug("Successfully removed hidden app with identifier \"\(appIdentifier.bundleIdentifier)\"")
		}
	}
}
