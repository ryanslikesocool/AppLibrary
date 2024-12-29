internal import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let additionalApplicationGroups = AdditionalApplicationGroups.self

	enum AdditionalApplicationGroups {
		private static let localizationTable = LocalizationTableResource("AdditionalApplicationGroups")

		public static let item: Item.Type = Item.self
		public static let section: Section.Type = Section.self

		public enum Item {
			public static let recentlyAdded = RecentlyAdded.self
			public static let recentlyUpdated = RecentlyUpdated.self

			public enum RecentlyAdded {
				public static let label = LocalizedStringResource("ITEM.RECENTLY_ADDED.LABEL", table: localizationTable)
				public static let description = LocalizedStringResource("ITEM.RECENTLY_ADDED.DESCRIPTION", table: localizationTable)
			}

			public enum RecentlyUpdated {
				public static let label = LocalizedStringResource("ITEM.RECENTLY_UPDATED.LABEL", table: localizationTable)
				public static let description = LocalizedStringResource("ITEM.RECENTLY_UPDATED.DESCRIPTION", table: localizationTable)
			}
		}

		public enum Section {
			public static let title = LocalizedStringResource("SECTION.TITLE", table: localizationTable)
			public static let description = LocalizedStringResource("SECTION.DESCRIPTION", table: localizationTable)
		}
	}
}
