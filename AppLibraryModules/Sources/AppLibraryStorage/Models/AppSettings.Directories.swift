import Foundation
import OSLog
import SerializationKit

public extension AppSettings {
	struct Directories {
		public private(set) var searchScopes: Set<String>

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
	static var defaultSearchScopes: Set<String> { [
		"/System/Applications",
		"/System/Library/CoreServices/Applications",
		"/Applications",
		"~/Applications",
	] }
}

// MARK: -

public extension AppSettings.Directories {
	mutating func tryAddSearchScope(withURL searchScopeURL: URL) {
		let searchScopePath = (searchScopeURL.path(percentEncoded: false) as NSString).abbreviatingWithTildeInPath
		tryAddSearchScope(withPath: searchScopePath)
	}

	mutating func tryAddSearchScope(withPath searchScopePath: String) {
		if searchScopes.insert(searchScopePath).inserted {
			Logger.module.debug("Added new search scope \(searchScopePath).")
		}
	}

	mutating func removeSearchScope(withPath searchScopePath: String) {
		if searchScopes.remove(searchScopePath) != nil {
			Logger.module.debug("Removed search scope \(searchScopePath).")
		}
	}

	func getURL(forPath searchScopePath: String) -> URL? {
		URL(filePath: (searchScopePath as NSString).expandingTildeInPath)
	}
}
