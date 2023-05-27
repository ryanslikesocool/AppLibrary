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
	private enum CodingKeys: CodingKey {
		case searchScopes
		case hiddenApps
	}

	init(from decoder: Decoder) throws {
		self.init()

		let container = try decoder.container(keyedBy: CodingKeys.self)

		searchScopes = try container.decode(forKey: .searchScopes) ?? searchScopes
		hiddenApps = try container.decode(forKey: .hiddenApps) ?? hiddenApps
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(searchScopes, forKey: .searchScopes)
		try container.encode(hiddenApps, forKey: .hiddenApps)
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
