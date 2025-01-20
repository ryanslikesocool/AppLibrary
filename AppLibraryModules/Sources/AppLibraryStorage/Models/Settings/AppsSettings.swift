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

		if let encodedApplicationVisibilityFlags = try container.decodeIfPresent([String: ApplicationVisibility.Set].self, forKey: .applicationVisibilityFlags) {
			applicationVisibilityFlags = encodedApplicationVisibilityFlags.mapKeys(
				ApplicationModelIdentifier.init(bundleIdentifier:),
				uniquingKeysWith: { _, newValue in newValue }
			)
		}
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(searchScopes, forKey: .searchScopes)

		let encodableApplicationVisibilityFlags: [String: ApplicationVisibility.Set] = applicationVisibilityFlags
			.filter { _, value in
				// Only encode modified items
				value != .all
			}
			.mapKeys(
				\.bundleIdentifier,
				uniquingKeysWith: { _, newValue in newValue }
			)
		try container.encode(encodableApplicationVisibilityFlags, forKey: .applicationVisibilityFlags)
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
