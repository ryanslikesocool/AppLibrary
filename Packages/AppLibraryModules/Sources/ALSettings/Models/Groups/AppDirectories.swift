import AppKit
import Foundation
import LoveCore

public extension AppSettings {
	struct AppDirectories: Hashable, Codable {
		public var appDirectories: [AppDirectory] = []

		public init() { }

		public mutating func restoreBookmarks() {
			do {
				try appDirectories.mutatingForEach { directory in
					try directory.restoreAccess()
				}
			} catch {
				print("Could not restore bookmarks: \(error)")
			}
		}
	}
}

// MARK: - App Directory

public extension AppSettings.AppDirectories {
	struct AppDirectory: Identifiable, Hashable, Codable, CustomStringConvertible {
		public let id: UUID = UUID()
		public var url: URL?
		public var bookmark: Data!
		public var apps: [AppIdentifier] = []

		public init(url: URL) throws {
			self.url = url
			try saveBookmarkData(for: url)
			try restoreAccess()
			try loadApplications()
		}

		public var description: String { url?.lastPathComponent ?? "ERROR" }

		public mutating func restoreAccess() throws {
			var isStale = false
			let url = try URL(resolvingBookmarkData: bookmark, options: [.withSecurityScope], relativeTo: nil, bookmarkDataIsStale: &isStale)
			if isStale {
				print("Bookmark is stale, need to save a new one... ")
				try saveBookmarkData(for: url)
			}
			self.url = url
		}

		private mutating func saveBookmarkData(for url: URL) throws {
			bookmark = try url.bookmarkData(options: [.withSecurityScope, .securityScopeAllowOnlyReadAccess], includingResourceValuesForKeys: nil, relativeTo: nil)
		}

		private mutating func loadApplications() throws {
			guard let url else {
				return
			}

			let fileManager = FileManager.default
			var urls: [URL] = []

			guard fileManager.fileExists(atPath: url.path()) else {
				return
			}
			let contents: [URL] = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
			urls.append(contentsOf: contents)

			apps = urls.map { AppIdentifier(url: $0) }
		}

		// MARK: - Codable

		private enum CodingKeys: String, CodingKey {
			case bookmark
			case apps
		}

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)

			bookmark = try container.decodeIfPresent(Data.self, forKey: .bookmark)
			apps = try container.decode([AppIdentifier].self, forKey: .apps)

			try restoreAccess()
		}
	}
}

// MARK: - Recommended Directories

public extension AppSettings.AppDirectories {
	static var recommendedDirectories: [RecommendedDirectory] { [
		"~/Applications/",
		"/Applications/",
		"/System/Applications/",
		// "/System/Library/CoreServices/",
		// "/System/Library/CoreServices/Applications/",
	] }

	struct RecommendedDirectory: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
		public let url: URL
		public let hiddenApps: [String]

		public var description: String { url.compressingTildeInPath }

		public init(url: URL, hiddenApps: [String] = []) {
			self.url = url
			self.hiddenApps = hiddenApps
		}

		public init?(path: String, hiddenApps: [String] = []) {
			guard let url = URL(string: path) else {
				return nil
			}
			self.init(url: url, hiddenApps: hiddenApps)
		}

		public init(stringLiteral value: String) {
			let url = URL(string: value)!
			self.init(url: url)
		}
	}
}

// MARK: - Privacy & Consent

public extension AppSettings.AppDirectories {
	mutating func promptForDirectory(_ directoryURL: URL? = nil) {
		let openPanel = NSOpenPanel()
		openPanel.message = "Choose an application directory"
		openPanel.prompt = "Choose"
		openPanel.allowedContentTypes = [.directory]
		openPanel.allowsOtherFileTypes = false
		openPanel.canChooseFiles = false
		openPanel.canChooseDirectories = true
		openPanel.directoryURL = directoryURL

		_ = openPanel.runModal()
		guard let result = openPanel.urls.first else {
			return
		}

		do {
			let newDirectory = try AppDirectory(url: result)
			appDirectories.append(newDirectory)
		} catch {
			print("Could not save app directory: \(error)")
		}
	}
}
