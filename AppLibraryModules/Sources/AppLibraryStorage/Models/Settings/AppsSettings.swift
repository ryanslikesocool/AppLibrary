import AppLibraryCommon
import Combine
import OSLog

@MainActor
public final class AppsSettings: ObservableObject {
	@Published public var searchScopes: Set<URL>

	/// The visibility flags for applications, as defined by the user.
	///
	/// Only key-value pairs where the value is not ``ApplicationVisibility/Set/visible`` are serialized.
	@Published public var applicationVisibilityFlags: [ApplicationModelIdentifier: ApplicationVisibility.Set]

	public init() {
		searchScopes = Set([URL].defaultSearchScopes)
		applicationVisibilityFlags = .default
	}
}

// MARK: - Codable

// NOTE: Implement `Codable` manually since values may change in the future.

extension AppsSettings: @preconcurrency Encodable, @preconcurrency Decodable {
	private enum CodingKeys: CodingKey {
		case searchScopes
		case applicationVisibilityFlags
	}

	public convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		// NOTE: Use `decodeIfPresent` when possible to avoid issues when adding new settings.

		searchScopes = try container.decodeIfPresent(Set<URL>.self, forKey: .searchScopes) ?? searchScopes
		applicationVisibilityFlags = try container.decodeIfPresent([ApplicationModelIdentifier: ApplicationVisibility.Set].self, forKey: .applicationVisibilityFlags) ?? applicationVisibilityFlags
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(searchScopes, forKey: .searchScopes)
		try container.encode(applicationVisibilityFlags, forKey: .applicationVisibilityFlags)
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
