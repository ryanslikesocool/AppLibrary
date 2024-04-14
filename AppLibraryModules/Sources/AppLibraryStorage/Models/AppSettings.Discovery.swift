import Foundation
import OSLog
import SerializationKit

public extension AppSettings {
	struct Discovery {
		public private(set) var searchScopes: Set<String>

		init() {
			searchScopes = Self.defaultSearchScopes
		}
	}
}

// MARK: - Sendable

extension AppSettings.Discovery: Sendable { }

// MARK: - Equatable

extension AppSettings.Discovery: Equatable { }

// MARK: - Hashable

extension AppSettings.Discovery: Hashable { }

// MARK: - Codable

extension AppSettings.Discovery: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let defaultSettings: Self = Self()

		searchScopes = try container.decodeIfPresent(forKey: .searchScopes) ?? defaultSettings.searchScopes
	}
}

// MARK: - SettingsFile

extension AppSettings.Discovery: SettingsFile {
	public static var fileName: String { "discovery.plist" }
}

// MARK: - Constants

public extension AppSettings.Discovery {
	static var defaultSearchScopes: Set<String> { [
		"/System/Applications",
		"/System/Library/CoreServices/Applications",
		"/Applications",
		"~/Applications",
	] }
}

// MARK: -

public extension AppSettings.Discovery {
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
