import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let applicationGroupCriteriaPicker = ApplicationGroupCriteriaPicker.self

	/// ## Topics
	/// - ``applicationGroupCriteriaPicker``
	enum ApplicationGroupCriteriaPicker {
		private static let localizationTable = LocalizationTableResource("ApplicationGroupCriteriaPicker")

		public static let item = Item.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static var none: None.Type { None.self }
			public static var category: Category.Type { Category.self }

			/// ## Topics
			/// - ``category``
			public enum Category {
				public static let title = LocalizedStringResource("ITEM.CATEGORY.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``none``
			public enum None {
				public static let title = LocalizedStringResource("ITEM.NONE.TITLE", table: localizationTable)
			}
		}
	}
}
