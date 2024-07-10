import AppLibraryCommon
import Foundation

public final class GeneralSettings {
	@Published public var appearance: Appearance?

	public init() {
		appearance = nil
	}
}

// MARK: - Hashable

public extension GeneralSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(appearance)
	}
}

// MARK: - Codable

public extension GeneralSettings {
	private enum CodingKeys: CodingKey {
		case appearance
	}

	convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		appearance = try container.decodeIfPresent(forKey: .appearance) ?? appearance
		appearance.apply()
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(appearance, forKey: .appearance)
	}
}

// MARK: - SettingsFile

extension GeneralSettings: SettingsFile {
	public static let shared: GeneralSettings = .load()

	public static let category: SettingsCategory = .general
}
