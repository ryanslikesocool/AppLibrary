import Foundation

extension AppSettings {
	struct Directories: Hashable, Codable {
		var searchScopes: Set<URL>
		var hiddenApps: Set<String>

		init() {
			searchScopes = [
				URL(filePath: "/System/Applications"),
				URL(filePath: "/System/Library/CoreServices/Applications"),
				URL(filePath: "/Applications"),
				URL(filePath: "/Users/ryanboyer/Applications"),
			]
			hiddenApps = []
		}
	}
}
