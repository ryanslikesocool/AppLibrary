import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var libraryLayoutPicker: LibraryLayoutPicker.Type { LibraryLayoutPicker.self }

	/// ## Topics
	/// - ``libraryLayoutPicker``
	enum LibraryLayoutPicker {
		private static let localizationTable = LocalizationTableResource("LibraryLayoutPicker")

		public static var item: Item.Type { Item.self }

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static var list: List.Type { List.self }
			public static var grid: Grid.Type { Grid.self }

			/// ## Topics
			/// - ``list``
			public enum Grid {
				public static let title = LocalizedStringResource("ITEM.GRID.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``grid``
			public enum List {
				public static let title = LocalizedStringResource("ITEM.LIST.TITLE", table: localizationTable)
			}
		}
	}
}
