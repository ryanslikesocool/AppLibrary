import AppLibraryCommon
import Foundation

public final class LayoutSettings {
	@Published public var layout: LibraryLayout

	@Published public var groupCriteria: GroupCriteria?
	@Published public var additionalGroups: AdditionalGroupFlags

	public init() {
		layout = .list
		groupCriteria = .category
		additionalGroups = .all
	}
}

// MARK: - Hashable

public extension LayoutSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(layout)
		hasher.combine(groupCriteria)
		hasher.combine(additionalGroups)
	}
}

// MARK: - Codable

public extension LayoutSettings {
	private enum CodingKeys: CodingKey {
		case layout
		case groupCriteria
		case additionalGroups
	}

	convenience init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		layout = try container.decodeIfPresent(forKey: .layout) ?? layout
		groupCriteria = try container.decodeIfPresent(forKey: .groupCriteria) ?? groupCriteria
		additionalGroups = try container.decodeIfPresent(forKey: .additionalGroups) ?? additionalGroups
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(layout, forKey: .layout)
		try container.encode(groupCriteria, forKey: .groupCriteria)
		try container.encode(additionalGroups, forKey: .additionalGroups)
	}
}

// MARK: - SettingsFile

extension LayoutSettings: SettingsFile {
	public static let shared: LayoutSettings = .load()

	public static let category: SettingsCategory = .layout
}
