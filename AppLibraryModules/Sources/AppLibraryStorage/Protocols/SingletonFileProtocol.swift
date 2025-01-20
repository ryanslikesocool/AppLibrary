import AppLibraryCommon
import Foundation
import OSLog

@MainActor
public protocol SingletonFileProtocol: LocalFileProtocol, ObservableObject {
	static var shared: Self { get }

	static var fileURL: URL { get }

	init()

	/// With the default ``read`` implementation, this is called immediately after successfully reading the file.
	/// Perform any necessary setup here.
	// Shadows ``LocalFileProtocol.initialize()``
	func initialize()
}

// MARK: - Default Implementation

public extension SingletonFileProtocol {
	func initialize() { }
}

// MARK: - Intrinsic

public extension SingletonFileProtocol {
	static func read() -> Self {
		let fileURL: URL = Self.fileURL

		do {
			let result = try Self(contentsOf: fileURL)
			result.initialize()
			return result
		} catch {
			Logger.singletonFileProtocol.error("""
			Failed to read file:
			- Type: \(Self.self)
			- URL: \(fileURL)
			- Error: \(error)
			""")
			return Self()
		}
	}

	func write() {
		let fileURL: URL = Self.fileURL

		do {
			try write(to: fileURL)

			Logger.singletonFileProtocol.debug("""
			Successfully wrote file:
			- Type: \(Self.self)
			- URL: \(fileURL)
			""")
		} catch {
			Logger.singletonFileProtocol.error("""
			Failed to write file:
			- Type: \(Self.self)
			- URL: \(fileURL)
			- Error: \(error)
			""")
		}
	}
}

// MARK: - Constants

private extension Logger {
	static let singletonFileProtocol: Self = Self(category: (any SingletonFileProtocol).self)
}