import Foundation
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
			print("Failed to load \(Self.fileName) from \(directory).")
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
			print("Failed to save \(Self.fileName) to \(directory).")
		}
	}

	// MARK: -

	mutating func prepare() { }
}
