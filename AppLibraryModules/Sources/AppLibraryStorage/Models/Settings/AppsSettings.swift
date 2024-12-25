import AppLibraryCommon
import Combine
import OSLog

public struct AppsSettings {
	public var applicationHideFlags: [ApplicationModelIdentifier: ApplicationHideFlag.Set]

	public init() {
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
		case applicationHideFlags
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

//		if let encodedApplicationHideFlags: [String: ApplicationHideFlags] = try container.decodeIfPresent([String: ApplicationHideFlags].self, forKey: .applicationHideFlags) {
//			applicationHideFlags = encodedApplicationHideFlags.reduce(into: [ApplicationIdentifier: ApplicationHideFlags]()) { result, element in
//				let components: [String] = element.key.components(separatedBy: .newlines)
//				assert(components.count == 2)
//				let newKey = ApplicationIdentifier(components[0], named: components[1])
//				result[newKey] = element.value
//			}
//		}

		applicationHideFlags = try container.decodeIfPresent([ApplicationModelIdentifier: ApplicationHideFlag.Set].self, forKey: .applicationHideFlags) ?? applicationHideFlags
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(applicationHideFlags, forKey: .applicationHideFlags)
	}
}

// MARK: - SingletonStorageFile

extension AppsSettings: SingletonStorageFile {
	public static let fileURL: URL = URL.settingsDirectory
		.appending(component: "apps.plist", directoryHint: .notDirectory)

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

		let messagePrefix: String = if inserted {
			"Successfully added"
		} else {
			"Failed to add"
		}

		Logger.module.debug("""
		\(messagePrefix) hidden app.
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}

	mutating func removeApplicationHideFlags(for applicationIdentifier: ApplicationModelIdentifier) {
		let removed: Bool = applicationHideFlags.removeValue(forKey: applicationIdentifier) != nil

		let messagePrefix: String = if removed {
			"Successfully removed"
		} else {
			"Failed to remove"
		}

		Logger.module.debug("""
		\(messagePrefix) hidden app.
		- Bundle Identifier: \(applicationIdentifier.bundleIdentifier)
		""")
	}
}
