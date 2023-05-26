import Foundation

extension AppSettings {
	struct Directories: Hashable, Codable {
		var searchScopes: [URL]
		var hiddenApps: [String]

		init() {
			searchScopes = [
				URL(filePath: "/System/Applications"),
				URL(filePath: "/System/Library/CoreServices/Applications"),
				URL(filePath: "/Applications"),
				URL.homeDirectory.appending(path: "Applications")
			]
			hiddenApps = []
		}

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
}
