import AppKit
import Foundation
import LoveCore

struct Bookmarks {
	static let writeOptions: NSURL.BookmarkCreationOptions = [.withSecurityScope, .securityScopeAllowOnlyReadAccess]
	static let readOptions: NSURL.BookmarkResolutionOptions = .withSecurityScope

	private var bookmarkData: [String: Data] {
		get { AppSettings.get(for: .bookmarkData) ?? [:] }
		set { AppSettings.set(newValue, for: .bookmarkData) }
	}
	var isEmpty: Bool { bookmarkData.isEmpty }

	private(set) var urls: [URL] = []

	mutating func load() {
		urls = bookmarkData.values.compactMap { restoreFileAccess(with: $0) }
	}

	mutating func unload() {
		urls.removeAll()
	}

	mutating func reload() {
		unload()
		load()
	}

	mutating func saveBookmarkData(for directory: URL) {
		do {
			let data = try directory.bookmarkData(options: Bookmarks.writeOptions, includingResourceValuesForKeys: nil, relativeTo: nil)
			bookmarkData[directory.path()] = data
		} catch {
			print("Failed to save bookmark data for \(directory)", error)
		}
	}

	mutating func removeBookmark(for directory: URL) {
		var bookmarkData = self.bookmarkData
		bookmarkData.removeValue(forKey: directory.path())
		self.bookmarkData = bookmarkData
		reload()
	}

	private mutating func restoreFileAccess(with bookmarkData: Data) -> URL? {
		do {
			var isStale = false
			let url = try URL(resolvingBookmarkData: bookmarkData, options: Bookmarks.readOptions, relativeTo: nil, bookmarkDataIsStale: &isStale)
			if isStale {
				print("Bookmark is stale, need to save a new one... ")
				saveBookmarkData(for: url)
			}
			return url
		} catch {
			print("Error resolving bookmark:", error)
			return nil
		}
	}

	func accessDirectory(_ directory: URL, body: @escaping (URL) throws -> Void) rethrows {
		if !directory.startAccessingSecurityScopedResource() {
			print("startAccessingSecurityScopedResource returned false. This directory might not need it, or this URL might not be a security scoped URL, or maybe something's wrong?")
		}

		try body(directory)

		directory.stopAccessingSecurityScopedResource()
	}

	func iterateURLs(body: @escaping (URL) throws -> Void) rethrows {
		for url in urls {
			try accessDirectory(url, body: body)
		}
	}

	mutating func promptForDirectory() {
		let openPanel = NSOpenPanel()
		openPanel.message = "Choose an application directory"
		openPanel.prompt = "Choose"
		openPanel.allowedContentTypes = [.directory]
		openPanel.allowsOtherFileTypes = false
		openPanel.canChooseFiles = false
		openPanel.canChooseDirectories = true

		_ = openPanel.runModal()
		if let result = openPanel.urls.first {
			saveBookmarkData(for: result)
		}
	}
}
