import AppLibraryCommon
import Combine
import OSLog

@MainActor
public final class AppsSettings: ObservableObject {
	@Published public var searchScopes: Set<URL>
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

// MARK: -

public extension AppsSettings {
	func hideApplication(with applicationIdentifier: ApplicationModelIdentifier) {
		var visibilityFlags = applicationVisibilityFlags[applicationIdentifier, default: .all]
		// NOTE: Because it is `mutating`, the `remove(_:)` operation must be the right side of the `!=` operation.
		let removed = visibilityFlags != visibilityFlags.remove(.browser)
		applicationVisibilityFlags[applicationIdentifier] = visibilityFlags

		Logger.module.debug("""
		\(removed ? "Successfully changed" : "Failed to change") visibility modifiers:
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}

	func removeApplicationVisibilityFlags(for applicationIdentifier: ApplicationModelIdentifier) {
		let removed: Bool = applicationVisibilityFlags.removeValue(forKey: applicationIdentifier) != nil

		Logger.module.debug("""
		\(removed ? "Successfully removed" : "Failed to remove") visibility modifiers:
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}

	func addSearchScope(at url: URL) {
		let added = searchScopes.insert(url).inserted

		Logger.module.debug("""
		\(added ? "Successfully added" : "Failed to add") search scope:
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}

	func removeSearchScope(at url: URL) {
		let removed = searchScopes.remove(url) != nil

		Logger.module.debug("""
		\(removed ? "Successfully removed" : "Failed to remove") search scope:
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}
}
