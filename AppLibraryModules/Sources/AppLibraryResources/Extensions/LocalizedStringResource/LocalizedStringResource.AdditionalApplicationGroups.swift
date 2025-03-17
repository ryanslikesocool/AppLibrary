import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var additionalApplicationGroups: AdditionalApplicationGroups.Type { AdditionalApplicationGroups.self }

	/// ## Topics
	/// - ``additionalApplicationGroups``
	enum AdditionalApplicationGroups {
		private static let localizationTable = LocalizationTableResource("AdditionalApplicationGroups")

		public static var item: Item.Type { Item.self }
		public static var section: Section.Type { Section.self }

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static var recentlyAdded: RecentlyAdded.Type { RecentlyAdded.self }
			public static var recentlyUpdated: RecentlyUpdated.Type { RecentlyUpdated.self }

			/// ## Topics
			/// - ``recentlyAdded``
			public enum RecentlyAdded {
				public static let title = LocalizedStringResource("ITEM.RECENTLY_ADDED.TITLE", table: localizationTable)
				public static let description = LocalizedStringResource("ITEM.RECENTLY_ADDED.DESCRIPTION", table: localizationTable)
			}

			/// ## Topics
			/// - ``recentlyUpdated``
			public enum RecentlyUpdated {
				public static let title = LocalizedStringResource("ITEM.RECENTLY_UPDATED.TITLE", table: localizationTable)
				public static let description = LocalizedStringResource("ITEM.RECENTLY_UPDATED.DESCRIPTION", table: localizationTable)
			}
		}

		/// ## Topics
		/// - ``section``
		public enum Section {
			public static let title = LocalizedStringResource("SECTION.TITLE", table: localizationTable)
			public static let description = LocalizedStringResource("SECTION.DESCRIPTION", table: localizationTable)
		}
	}
}
