import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let libraryLayoutPicker = LibraryLayoutPicker.self

	/// ## Topics
	/// - ``libraryLayoutPicker``
	enum LibraryLayoutPicker {
		private static let localizationTable = LocalizationTableResource("LibraryLayoutPicker")

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let list = LocalizedStringResource("ITEM.LIST", table: localizationTable)
			public static let grid = LocalizedStringResource("ITEM.GRID", table: localizationTable)
		}
	}
}
