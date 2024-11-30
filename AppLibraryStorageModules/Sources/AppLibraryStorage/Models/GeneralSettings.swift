import AppLibraryCommon
import Combine
import Foundation

public struct GeneralSettings {
	public var appearance: Appearance?

	public init() {
		appearance = nil
	}
}

// MARK: - Equatable

extension GeneralSettings: Equatable { }

// MARK: - Hashable

extension GeneralSettings: Hashable { }

// MARK: - Codable

extension GeneralSettings: Codable {
	private enum CodingKeys: CodingKey {
		case appearance
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

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

// MARK: - SingletonStorageFile

extension GeneralSettings: SingletonStorageFile {
	public static let fileURL: URL = URL.settingsDirectory
		.appending(component: "general.plist", directoryHint: .notDirectory)

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

private extension GeneralSettings {
	@MainActor
	static let sharedSubscriber: AnyCancellable = $shared.publisher
		.sink { newValue in
			// TODO: don't write on every change
			// only write after a certain time interval or when application enters background

			newValue.write()
		}
}