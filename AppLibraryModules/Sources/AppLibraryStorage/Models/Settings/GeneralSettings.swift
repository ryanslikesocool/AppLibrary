import AppLibraryCommon
import Combine
import Foundation

@MainActor
public final class GeneralSettings: ObservableObject {
	@Published public var appearance: Appearance
	@Published public var openAtLogin: OpenAtLogin

	public init() {
		appearance = .system
		openAtLogin = false
	}
}

// MARK: - Codable

// NOTE: Implement `Codable` manually since values may change in the future.

extension GeneralSettings: @preconcurrency Encodable, @preconcurrency Decodable {
	private enum CodingKeys: CodingKey {
		case appearance
	}

	public convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		// NOTE: Use `decodeIfPresent` when possible to avoid issues when adding new settings.

		let appearance = try container.decodeIfPresent(Appearance.self, forKey: .appearance) ?? appearance
		self.appearance = appearance

		Task { @MainActor in
			appearance.apply()
		}
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(appearance, forKey: .appearance)
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
