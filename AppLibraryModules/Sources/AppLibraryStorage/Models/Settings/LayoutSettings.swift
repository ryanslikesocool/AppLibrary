import AppLibraryCommon
import Combine
import Foundation

@MainActor
public final class LayoutSettings: ObservableObject {
	@Published public var layout: LibraryLayout
	@Published public var groupCriteria: ApplicationGroupCriteria?
	@Published public var additionalGroups: AdditionalApplicationGroup.Set
	@Published public var infoVisibility: ApplicationInfoVisibility.Set

	public init() {
		layout = .list
		groupCriteria = .category
		additionalGroups = .all
		infoVisibility = .none
	}
}

// MARK: - Codable

// NOTE: Implement `Codable` manually since values may change in the future.

extension LayoutSettings: @preconcurrency Encodable, @preconcurrency Decodable {
	private enum CodingKeys: CodingKey {
		case layout
		case groupCriteria
		case additionalGroups
		case infoVisibility
	}

	public convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		// NOTE: Use `decodeIfPresent` when possible to avoid issues when adding new settings.

		layout = try container.decodeIfPresent(LibraryLayout.self, forKey: .layout) ?? layout
		groupCriteria = try container.decodeIfPresent(ApplicationGroupCriteria.self, forKey: .groupCriteria) ?? groupCriteria
		additionalGroups = try container.decodeIfPresent(AdditionalApplicationGroup.Set.self, forKey: .additionalGroups) ?? additionalGroups
		infoVisibility = try container.decodeIfPresent(ApplicationInfoVisibility.Set.self, forKey: .infoVisibility) ?? infoVisibility
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(layout, forKey: .layout)
		try container.encode(groupCriteria, forKey: .groupCriteria)
		try container.encode(additionalGroups, forKey: .additionalGroups)
		try container.encode(infoVisibility, forKey: .infoVisibility)
	}
}

// MARK: - LocalFileProtocol

extension LayoutSettings: LocalFileProtocol { }

// MARK: - SingletonFileProtocol

extension LayoutSettings: SingletonFileProtocol {
	public static let shared: LayoutSettings = read()
}

// MARK: - SettingsFileProtocol

extension LayoutSettings: SettingsFileProtocol {
	public nonisolated static let category: SettingsCategory = .layout
}
