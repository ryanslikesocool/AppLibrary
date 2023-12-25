import Foundation
import SerializationKit

public extension AppSettings {
	struct Directories {
		public private(set) var searchScopes: [URL]

		init() {
			searchScopes = [
				URL(filePath: "/System/Applications"),
				URL(filePath: "/System/Library/CoreServices/Applications"),
				URL(filePath: "/Applications"),
				URL.homeDirectory.appending(path: "Applications"),
			]
		}
	}
}

// MARK: - Hashable

extension AppSettings.Directories: Hashable { }

// MARK: - Codable

extension AppSettings.Directories: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let dflt: Self = Self()

		searchScopes = try container.decodeIfPresent(forKey: .searchScopes) ?? dflt.searchScopes
	}
}

// MARK: - SettingsFile

extension AppSettings.Directories: SettingsFile {
	public static let fileName: String = "directories.plist"
}

// MARK: -

public extension AppSettings.Directories {
	mutating func tryAdd(searchScope: URL) {
		if !searchScopes.contains(searchScope) {
			searchScopes.append(searchScope)
		}
	}

	mutating func removeSearchScope(at index: Int) {
		searchScopes.remove(at: index)
	}
}
