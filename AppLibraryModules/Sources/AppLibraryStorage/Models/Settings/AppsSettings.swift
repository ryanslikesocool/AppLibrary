import AppLibraryCommon
import Combine
import OSLog

public struct AppsSettings {
	public var searchScopes: Set<URL>
	public var applicationVisibilityFlags: [ApplicationModelIdentifier: ApplicationVisibility.Set]

	public init() {
		searchScopes = Set([URL].defaultSearchScopes)
		applicationVisibilityFlags = .default
	}
}

// MARK: - Equatable

extension AppsSettings: Equatable { }

// MARK: - Hashable

extension AppsSettings: Hashable { }

// MARK: - Codable

extension AppsSettings: Codable {
	private enum CodingKeys: CodingKey {
		case searchScopes
		case applicationVisibilityFlags
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

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

// MARK: - SingletonStorageFile

extension AppsSettings: SingletonStorageFile {
	public static let fileURL: URL = URL(for: .apps)

	@ObservingCurrentValue
	public static var shared: Self = Self.read(sharedSubscriber) {
		didSet {
			// TODO: don't write on every change
			// only write after a certain time interval or when application enters background

			shared.write()
		}
	}
}

// MARK: -

private extension AppsSettings {
	@MainActor
	static let sharedSubscriber: AnyCancellable = $shared.publisher
		.sink { newValue in
			// TODO: don't write on every change
			// only write after a certain time interval or when application enters background

			newValue.write()
		}
}

// MARK: -

public extension AppsSettings {
	mutating func hideApplication(with applicationIdentifier: ApplicationModelIdentifier) {
		var visibilityFlags = applicationVisibilityFlags[applicationIdentifier, default: .all]
		// NOTE: Because it is `mutating`, the `remove(_:)` operation must be the right side of the `!=` operation.
		let removed = visibilityFlags != visibilityFlags.remove(.browser)
		applicationVisibilityFlags[applicationIdentifier] = visibilityFlags

		Logger.module.debug("""
		\(removed ? "Successfully changed" : "Failed to change") visibility modifiers:
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}

	mutating func removeApplicationVisibilityFlags(for applicationIdentifier: ApplicationModelIdentifier) {
		let removed: Bool = applicationVisibilityFlags.removeValue(forKey: applicationIdentifier) != nil

		Logger.module.debug("""
		\(removed ? "Successfully removed" : "Failed to remove") visibility modifiers:
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}

	mutating func addSearchScope(at url: URL) {
		let added = searchScopes.insert(url).inserted

		Logger.module.debug("""
		\(added ? "Successfully added" : "Failed to add") search scope:
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}

	mutating func removeSearchScope(at url: URL) {
		let removed = searchScopes.remove(url) != nil

		Logger.module.debug("""
		\(removed ? "Successfully removed" : "Failed to remove") search scope:
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}
}
