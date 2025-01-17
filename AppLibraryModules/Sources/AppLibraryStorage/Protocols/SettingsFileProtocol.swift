import AppLibraryCommon
import Foundation

public protocol SettingsFileProtocol: SingletonFileProtocol where
	TopLevelEncoder == PropertyListEncoder,
	TopLevelDecoder == PropertyListDecoder
{
	nonisolated static var category: SettingsCategory { get }
}

// MARK: - Default Implementation

public extension SettingsFileProtocol {
	static var topLevelEncoder: TopLevelEncoder {
		.shared
			.with(outputFormat: .binary)
	}

	static var topLevelDecoder: TopLevelDecoder {
		.shared
	}

	static var fileURL: URL {
		URL(for: category)
	}
}
