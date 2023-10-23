import Foundation

extension AppSettings {
	struct Directories: Hashable {
		var searchScopes: [URL]
		var hiddenApps: [String]

		init() {
			searchScopes = [
				URL(filePath: "/System/Applications"),
				URL(filePath: "/System/Library/CoreServices/Applications"),
				URL(filePath: "/Applications"),
				URL.homeDirectory.appending(path: "Applications"),
			]
			hiddenApps = [
				"com.DevelopedWithLove.AppLibrary",
			]
		}
	}
}

// MARK: - Codable

extension AppSettings.Directories: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let dflt: Self = Self()

		searchScopes = try container.decodeIfPresent([URL].self, forKey: .searchScopes) ?? dflt.searchScopes
		hiddenApps = try container.decodeIfPresent([String].self, forKey: .hiddenApps) ?? dflt.hiddenApps
	}
}

// MARK: - Utility

extension AppSettings.Directories {
	mutating func tryAdd(scope: URL) {
		if !searchScopes.contains(scope) {
			searchScopes.append(scope)
		}
	}

	mutating func tryAdd(hiddenApp bundleID: String) {
		if !hiddenApps.contains(bundleID) {
			hiddenApps.append(bundleID)
		}
	}
}
