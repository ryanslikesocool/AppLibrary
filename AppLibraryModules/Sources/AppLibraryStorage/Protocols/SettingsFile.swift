import AppLibraryCommon
import Foundation
import OSLog

public protocol SettingsFile: AnyObject, ObservableObject, Codable, Hashable {
	static var shared: Self { get }
	static var category: SettingsCategory { get }

	init()

	static func load() -> Self
	func save()
}

// MARK: - Default Implementation

public extension SettingsFile {
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.hashValue == rhs.hashValue
	}

	static func load() -> Self {
		let fileURL: URL = Utility.Settings.fileURL(for: Self.category)

		let data: Data
		do {
			data = try Data(contentsOf: fileURL)
		} catch {
			Logger.module.error("""
			Failed to read data at \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
			return Self()
		}

		do {
			return try PropertyListDecoder.shared.decode(Self.self, from: data)
		} catch {
			Logger.module.error("""
			Failed to decode \(Self.self) from data at \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
			return Self()
		}
	}

	func save() {
		let fileURL: URL = Utility.Settings.fileURL(for: Self.category)

		do {
			let fileManager = FileManager.default
			let directoryPath: String = fileURL.deletingLastPathComponent().path(percentEncoded: false)

			if !fileManager.fileExists(atPath: directoryPath) {
				try fileManager.createDirectory(
					atPath: directoryPath,
					withIntermediateDirectories: true
				)
			}
		} catch {
			Logger.module.error("""
			Failed to validate save directory at \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
		}

		let data: Data
		do {
			data = try PropertyListEncoder.shared.with(outputFormat: .xml).encode(self)
		} catch {
			Logger.module.error("""
			Failed to encode \(Self.self) to data:
			\(error.localizedDescription)
			""")
			return
		}

		do {
			try data.write(to: fileURL)
		} catch {
			Logger.module.error("""
			Failed to write \(Self.self) data to \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
		}

		Logger.module.debug("Successfully wrote \(Self.self) to \(fileURL.path(percentEncoded: false)).")
	}
}
