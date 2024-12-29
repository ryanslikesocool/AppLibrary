import AppLibraryCommon
import Combine
import OSLog

public struct AppsSettings {
	public var searchScopes: Set<URL>
	public var applicationHideFlags: [ApplicationModelIdentifier: ApplicationHideFlag.Set]

	public init() {
		searchScopes = Set(Constant.Settings.defaultSearchScopes)
		applicationHideFlags = Constant.Settings.defaultApplicationVisibility
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
		case applicationHideFlags
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		searchScopes = try container.decodeIfPresent(Set<URL>.self, forKey: .searchScopes) ?? searchScopes

		if let encodedApplicationHideFlags = try container.decodeIfPresent([String: ApplicationHideFlag.Set].self, forKey: .applicationHideFlags) {
			applicationHideFlags = encodedApplicationHideFlags.mapKeys(
				{ bundleIdentifier in ApplicationModelIdentifier(bundleIdentifier: bundleIdentifier) },
				uniquingKeysWith: { _, newValue in newValue }
			)
		}
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(searchScopes, forKey: .searchScopes)

		let encodableApplicationHideFlags: [String: ApplicationHideFlag.Set] = applicationHideFlags.mapKeys(
			{ key in key.bundleIdentifier },
			uniquingKeysWith: { _, newValue in newValue }
		)
		try container.encode(encodableApplicationHideFlags, forKey: .applicationHideFlags)
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
		var hideFlags = applicationHideFlags[applicationIdentifier] ?? .none
		let inserted = hideFlags.insert(.hiddenInBrowser).inserted
		applicationHideFlags[applicationIdentifier] = hideFlags

		let messagePrefix: StaticString = if inserted {
			"Successfully added"
		} else {
			"Failed to add"
		}

		Logger.module.debug("""
		\(messagePrefix) hidden app:
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}

	mutating func removeApplicationHideFlags(for applicationIdentifier: ApplicationModelIdentifier) {
		let removed: Bool = applicationHideFlags.removeValue(forKey: applicationIdentifier) != nil

		let messagePrefix: StaticString = if removed {
			"Successfully removed"
		} else {
			"Failed to remove"
		}

		Logger.module.debug("""
		\(messagePrefix) hidden app:
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}

	mutating func addSearchScope(at url: URL) {
		let messagePrefix: StaticString = if searchScopes.insert(url).inserted {
			"Successfully added"
		} else {
			"Failed to add"
		}

		Logger.module.debug("""
		\(messagePrefix) search scope:
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}

	mutating func removeSearchScope(at url: URL) {
		let messagePrefix: StaticString = if searchScopes.remove(url) != nil {
			"Successfully removed"
		} else {
			"Failed to remove"
		}

		Logger.module.debug("""
		\(messagePrefix) search scope:
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}
}
