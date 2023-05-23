import Foundation

extension URL {
	var isDirectory: Bool {
		return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
	}

	func getContents() -> [URL]? {
		let fm = FileManager.default
		let path = self.path()

		var items: [URL]?

		do {
			items = try fm.contentsOfDirectory(atPath: path).map { self.appending(path: $0) }
		} catch {
			print("Failed to read directory:", error)
		}

		return items
	}
}
