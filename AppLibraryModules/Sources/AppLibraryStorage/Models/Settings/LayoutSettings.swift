import AppLibraryCommon
import Combine
import Foundation

public struct LayoutSettings {
	public var layout: LibraryLayout

	public var groupCriteria: ApplicationGroupCriteria?
	public var additionalGroups: AdditionalApplicationGroup.Set

	public var infoVisibility: ApplicationInfoVisibility.Set

	public init() {
		layout = .list
		groupCriteria = .category
		additionalGroups = .all
		infoVisibility = .none
	}
}

// MARK: - Equatable

extension LayoutSettings: Equatable { }

// MARK: - Hashable

extension LayoutSettings: Hashable { }

// MARK: - Codable

extension LayoutSettings: Codable {
	private enum CodingKeys: CodingKey {
		case layout
		case groupCriteria
		case additionalGroups
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		layout = try container.decodeIfPresent(LibraryLayout.self, forKey: .layout) ?? layout
		groupCriteria = try container.decodeIfPresent(ApplicationGroupCriteria.self, forKey: .groupCriteria) ?? groupCriteria
		additionalGroups = try container.decodeIfPresent(AdditionalApplicationGroup.Set.self, forKey: .additionalGroups) ?? additionalGroups
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(layout, forKey: .layout)
		try container.encode(groupCriteria, forKey: .groupCriteria)
		try container.encode(additionalGroups, forKey: .additionalGroups)
	}
}

// MARK: - SingletonStorageFile

extension LayoutSettings: SingletonStorageFile {
	public static let fileURL: URL = URL(for: .layout)

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

private extension LayoutSettings {
	@MainActor
	static let sharedSubscriber: AnyCancellable = $shared.publisher
		.sink { newValue in
			// TODO: don't write on every change
			// only write after a certain time interval or when application enters background

			newValue.write()
		}
}
