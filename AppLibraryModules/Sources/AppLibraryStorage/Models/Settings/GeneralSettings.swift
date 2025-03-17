import AppLibraryCommon
import Combine
import Foundation

@MainActor
public final class GeneralSettings: ObservableObject {
	@Published public var openAtLogin: OpenAtLogin

	public init() {
		openAtLogin = OpenAtLogin()
	}
}

// MARK: - Codable

// NOTE: Implement `Codable` manually since values may change in the future.

extension GeneralSettings: @preconcurrency Encodable, @preconcurrency Decodable {
	private enum CodingKeys: CodingKey {
	}

	public convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		// NOTE: Use `decodeIfPresent` when possible to avoid issues when adding new settings.

	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

	}
}

// MARK: - LocalFileProtocol

extension GeneralSettings: LocalFileProtocol { }

// MARK: - SingletonFileProtocol

extension GeneralSettings: SingletonFileProtocol {
	public static let shared: GeneralSettings = read()
}

// MARK: - SettingsFileProtocol

extension GeneralSettings: SettingsFileProtocol {
	public nonisolated static let category: SettingsCategory = .general
}
