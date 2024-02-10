import Foundation
import OSLog
import SerializationKit

public protocol SettingsFile: Hashable, PlistCodable, SerializedFileConvertible {
	static var fileName: String { get }

	init?(directory: URL)

	func save()
	func save(directory: URL)

	mutating func prepare()
}

// MARK: - Default Implementation

public extension SettingsFile {
	// MARK: Read

	init?(directory: URL) {
		let url = directory.appending(path: Self.fileName, directoryHint: .notDirectory)
		do {
			try self.init(url: url)
		} catch {
			Logger.appLibrarySettings.error("Failed to load \(Self.fileName) from \(directory): \(error.localizedDescription)")
			return nil
		}
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
			Logger.appLibrarySettings.error("Failed to save \(Self.fileName) to \(directory): \(error.localizedDescription).")
		}
	}

	// MARK: -

	mutating func prepare() { }
}
