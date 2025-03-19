import AppLibraryCommon
import Combine
import OSLog

@MainActor
public final class AppsSettings: ObservableObject {
	@Published public var searchScopes: Set<URL>

	/// Configuration for applications, as defined by the user.
	///
	/// Only key-value pairs where the value is not equal to the default configuration are serialized.
	@Published public var applicationConfiguration: [ApplicationModelIdentifier: ApplicationConfiguration]

	public init() {
		searchScopes = Set([URL].defaultSearchScopes)
		applicationConfiguration = .default
	}
}

// MARK: - Codable

// NOTE: Implement `Codable` manually since values may change in the future.

extension AppsSettings: @preconcurrency Encodable, @preconcurrency Decodable {
	private enum CodingKeys: CodingKey {
		case searchScopes
		case applicationConfiguration
	}

	public convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		// NOTE: Use `decodeIfPresent` when possible to avoid issues when adding new settings.

		searchScopes = try container.decodeIfPresent(Set<URL>.self, forKey: .searchScopes) ?? searchScopes
		applicationConfiguration = try container.decodeIfPresent([ApplicationModelIdentifier: ApplicationConfiguration].self, forKey: .applicationConfiguration) ?? applicationConfiguration
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(searchScopes, forKey: .searchScopes)
		try container.encode(applicationConfiguration, forKey: .applicationConfiguration)
	}
}

// MARK: - LocalFileProtocol

extension AppsSettings: LocalFileProtocol { }

// MARK: - SingletonFileProtocol

extension AppsSettings: SingletonFileProtocol {
	public static let shared: AppsSettings = read()
}

// MARK: - SettingsFileProtocol

extension AppsSettings: SettingsFileProtocol {
	public nonisolated static let category: SettingsCategory = .apps
}
