import Foundation

public protocol StorageFile: Codable {
	init(contentsOf url: URL) throws

	func write(to url: URL) throws
}

// MARK: - Default Implementation

public extension StorageFile {
	init(contentsOf url: URL) throws {
		let data: Data = try Data(contentsOf: url)
		self = try PropertyListDecoder.shared.decode(Self.self, from: data)
	}

	func write(to url: URL) throws {
		try FileManager.default.createDirectory(
			at: url.deletingLastPathComponent(),
			withIntermediateDirectories: true
		)

		let data: Data = try PropertyListEncoder.shared.encode(self)
		try data.write(to: url, options: .atomic)
	}
}
