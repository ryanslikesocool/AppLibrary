import Combine
import Foundation
import OSLog

public protocol LocalFileProtocol: Codable {
	associatedtype TopLevelEncoder: Combine.TopLevelEncoder where
		TopLevelEncoder.Output == Data

	associatedtype TopLevelDecoder: Combine.TopLevelDecoder where
		TopLevelDecoder.Input == Data

	/// The top level encoder used to serialize instances of this type.
	static var topLevelEncoder: TopLevelEncoder { get }

	/// The top level decoder used to deserialize instances of this type.
	static var topLevelDecoder: TopLevelDecoder { get }

	init(contentsOf url: URL) throws

	func write(to url: URL) throws

//	/// With the default ``read`` implementation, this is called immediately after successfully reading the file.
//	/// Perform any necessary setup here.
//	mutating func initialize()
}

// MARK: - Default Implementation

public extension LocalFileProtocol {
	init(contentsOf url: URL) throws {
		let decoder = PropertyListDecoder.shared

		let data: Data = try Data(contentsOf: url)
		self = try decoder.decode(Self.self, from: data)
	}

	func write(to url: URL) throws {
		let encoder = PropertyListEncoder.shared
		encoder.outputFormat = .binary

		let fileManager = FileManager.default
		let directoryPath: String = url
			.deletingLastPathComponent()
			.path(percentEncoded: false)

		// NOTE: It's recommended to just attempt the operation
		// instead of checking if the file exists and then attempting.

//		if !fileManager.fileExists(atPath: directoryPath) {
		try fileManager.createDirectory(
			atPath: directoryPath,
			withIntermediateDirectories: true
		)
//		}

		let data: Data = try encoder.encode(self)
		try data.write(to: url)
	}

//	func initialize() { }
}
