import Combine
import Foundation
import AppLibraryCommon

@MainActor
public protocol SingletonStorageFile: DefaultableStorageFile {
	static var shared: Self { get set }

	static var fileURL: URL { get }

	mutating func initialize()
}

// MARK: - Default Implementation

public extension SingletonStorageFile {
	static func read(
		_ subscriber: @autoclosure @escaping () -> AnyCancellable
	) -> Self {
		defer {
			DispatchQueue.main.async {
				_ = subscriber()
			}
		}
		var result = readDefault(from: fileURL)
		result.initialize()
		return result
	}

	func write() {
		writeDefault(to: Self.fileURL)
	}

	mutating func initialize() { }
}
