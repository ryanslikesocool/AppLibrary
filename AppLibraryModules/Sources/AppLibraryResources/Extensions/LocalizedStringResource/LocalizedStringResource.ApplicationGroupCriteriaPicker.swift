import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let applicationGroupCriteriaPicker = ApplicationGroupCriteriaPicker.self

	/// ## Topics
	/// - ``applicationGroupCriteriaPicker``
	enum ApplicationGroupCriteriaPicker {
		private static let localizationTable = LocalizationTableResource("ApplicationGroupCriteriaPicker")

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let none = LocalizedStringResource("ITEM.NONE", table: localizationTable)
			public static let category = LocalizedStringResource("ITEM.CATEGORY", table: localizationTable)
		}
	}
}
