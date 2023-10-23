import Foundation

protocol SettingsFile: Hashable, Codable {
	static var fileName: String { get }

	init(data: Data) throws
	func toData() throws -> Data

	init?(directory: URL)
	init(url: URL) throws
	func save(directory: URL)
	func save(to url: URL) throws

	func prepare()
}

// MARK: - Default Implementation

extension SettingsFile {
	init(data: Data) throws {
		self = try AppSettings.plistDecoder.decode(Self.self, from: data)
	}

	func toData() throws -> Data {
		try AppSettings.plistEncoder.encode(self)
	}

	// MARK: Read

	init?(directory: URL) {
		let url = directory.appending(path: Self.fileName, directoryHint: .notDirectory)
		do {
			try self.init(url: url)
		} catch {
			print("Failed to load \(Self.fileName) from \(directory).")
			return nil
		}
	}

	init(url: URL) throws {
		let data = try Data(contentsOf: url)
		try self.init(data: data)
	}

	// MARK: Write

	func save() {
		save(directory: AppSettings.directoryURL)
	}

	func save(directory: URL) {
		let url = directory.appending(path: Self.fileName, directoryHint: .notDirectory)
		do {
			try save(to: url)
		} catch {
			print("Failed to save \(Self.fileName) to \(directory).")
		}
	}

	func save(to url: URL) throws {
		let fileManager = FileManager.default

		let directory = url.deletingLastPathComponent()
		if !fileManager.fileExists(atPath: directory.path) {
			try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
		}

		if !fileManager.fileExists(atPath: url.path) {
			fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
		}

		let data = try toData()
		try data.write(to: url)
	}
}
