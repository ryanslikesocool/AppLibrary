import Foundation
import LoveCore

struct AppState {
	var bookmarks: Bookmarks = Bookmarks()
	private(set) var applicationURLs: [URL] = []

	private(set) var isLoaded: Bool = false

	mutating func load() {
		bookmarks.load()
		loadApplicationURLs()
		isLoaded = true
	}

	mutating func unload() {
		isLoaded = false
		applicationURLs.removeAll()
		bookmarks.unload()
	}

	mutating func reload() {
		unload()
		load()
	}
}

// MARK: - Application URLs

extension AppState {
	static let recommendedURLs: [String] = [
		"~/Applications/",
		"/Applications/",
		"/System/Applications/",
//		"/System/Library/CoreServices/",
//		"/System/Library/CoreServices/Applications/",
	]

	private mutating func loadApplicationURLs() {
		let fileManager = FileManager.default
		var urls: [URL] = []

		do {
			try bookmarks.iterateURLs { url in
				guard fileManager.fileExists(atPath: url.path()) else {
					return
				}
				let contents: [URL] = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
				urls.append(contentsOf: contents)
			}
		} catch {
			print(error)
		}

		applicationURLs = urls
	}
}
