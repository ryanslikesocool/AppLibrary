import Foundation
import OSLog
import SerializationKit

public extension AppSettings {
	struct Directories {
		public private(set) var searchScopes: [URL]

		init() {
			searchScopes = Self.defaultSearchScopes
		}
	}
}

// MARK: - Sendable

extension AppSettings.Directories: Sendable { }

// MARK: - Equatable

extension AppSettings.Directories: Equatable { }

// MARK: - Hashable

extension AppSettings.Directories: Hashable { }

// MARK: - Codable

extension AppSettings.Directories: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let defaultSettings: Self = Self()

		searchScopes = try container.decodeIfPresent(forKey: .searchScopes) ?? defaultSettings.searchScopes
	}
}

// MARK: - SettingsFile

extension AppSettings.Directories: SettingsFile {
	public static var fileName: String { "directories.plist" }
}

// MARK: - Constants

public extension AppSettings.Directories {
	static var defaultSearchScopes: [URL] { [
		URL(filePath: "/System/Applications"),
		URL(filePath: "/System/Library/CoreServices/Applications"),
		URL(filePath: "/Applications"),
		URL.homeDirectory.appending(path: "Applications"),
	] }
}

// MARK: -

public extension AppSettings.Directories {
	mutating func tryAdd(searchScope newSearchScope: URL) {
		if !searchScopes.contains(newSearchScope) {
			searchScopes.append(newSearchScope)
			Logger.module.debug("Added new search scope \(newSearchScope.path(percentEncoded: false)).")
		}
	}

	mutating func removeSearchScope(at index: Int) {
		let removedSearchScope: URL = searchScopes.remove(at: index)
		Logger.module.debug("Removed search scope \(removedSearchScope.path(percentEncoded: false)).")
	}
}
