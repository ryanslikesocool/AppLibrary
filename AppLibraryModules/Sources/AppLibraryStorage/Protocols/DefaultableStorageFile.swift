import Foundation
import OSLog

public protocol DefaultableStorageFile: StorageFile {
	static func readDefault(from url: URL) -> Self

	func writeDefault(to url: URL)

	init()
}

// MARK: - Default Implementation

public extension DefaultableStorageFile {
	static func readDefault(from url: URL) -> Self {
		let result: Self

		do {
			result = try Self(contentsOf: url)
		} catch {
			Logger.module.error("""
			Failed to read \(Self.self).
			- URL: \(url)
			- Error: \(error)
			Falling back to default.
			""")
			result = Self()
		}

		return result
	}
}

public extension StorageFile {
	nonisolated func writeDefault(to url: URL) {
		do {
			try write(to: url)
		} catch {
			Logger.module.error("""
			Failed to write \(Self.self).
			- URL: \(url)
			- Error: \(error)
			""")
		}
	}
}
