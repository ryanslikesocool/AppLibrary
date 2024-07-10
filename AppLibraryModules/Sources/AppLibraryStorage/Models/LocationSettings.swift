import AppLibraryCommon
import OSLog

public final class LocationSettings {
	@Published public var searchScopes: Set<URL>

	public init() {
		searchScopes = Set(Constant.Settings.defaultSearchScopes)
	}
}

// MARK: - Hashable

public extension LocationSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(searchScopes)
	}
}

// MARK: - Codable

public extension LocationSettings {
	private enum CodingKeys: CodingKey {
		case searchScopes
	}

	convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		searchScopes = try container.decodeIfPresent(forKey: .searchScopes) ?? searchScopes
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(searchScopes, forKey: .searchScopes)
	}
}

// MARK: - SettingsFile

extension LocationSettings: SettingsFile {
	public static let shared: LocationSettings = .load()

	public static let category: SettingsCategory = .location
}

// MARK: -

public extension LocationSettings {
	func addSearchScope(at url: URL) {
		if searchScopes.insert(url).inserted {
			Logger.module.debug("Added new search scope \(url.abbreviatingWithTildeInPath).")
		}
	}

	func removeSearchScope(at url: URL) {
		if searchScopes.remove(url) != nil {
			Logger.module.debug("Removed search scope \(url.abbreviatingWithTildeInPath).")
		}
	}
}
