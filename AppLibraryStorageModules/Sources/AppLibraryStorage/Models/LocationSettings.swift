import AppLibraryCommon
import Combine
import OSLog

public struct LocationSettings {
	public var searchScopes: Set<URL>

	public init() {
		searchScopes = Set(Constant.Settings.defaultSearchScopes)
	}
}

// MARK: - Equatable

extension LocationSettings: Equatable { }

// MARK: - Hashable

extension LocationSettings: Hashable { }

// MARK: - Codable

extension LocationSettings: Codable {
	private enum CodingKeys: CodingKey {
		case searchScopes
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		searchScopes = try container.decodeIfPresent(Set<URL>.self, forKey: .searchScopes) ?? searchScopes
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(searchScopes, forKey: .searchScopes)
	}
}

// MARK: - SingletonStorageFile

extension LocationSettings: SingletonStorageFile {
	public static let fileURL: URL = URL.settingsDirectory
		.appending(component: "locations.plist", directoryHint: .notDirectory)

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

private extension LocationSettings {
	@MainActor
	static let sharedSubscriber: AnyCancellable = $shared.publisher
		.sink { newValue in
			// TODO: don't write on every change
			// only write after a certain time interval or when application enters background

			newValue.write()
		}
}

// MARK: -

public extension LocationSettings {
	mutating func addSearchScope(at url: URL) {
		let messagePrefix: String = if searchScopes.insert(url).inserted {
			"Successfully added"
		} else {
			"Failed to add"
		}

		Logger.module.debug("""
		\(messagePrefix) new search scope.
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}

	mutating func removeSearchScope(at url: URL) {
		let messagePrefix: String = if searchScopes.remove(url) != nil {
			"Successfully removed"
		} else {
			"Failed to remove"
		}

		Logger.module.debug("""
		\(messagePrefix) search scope.
		- Path: \(url.abbreviatingWithTildeInPath)
		""")
	}
}
