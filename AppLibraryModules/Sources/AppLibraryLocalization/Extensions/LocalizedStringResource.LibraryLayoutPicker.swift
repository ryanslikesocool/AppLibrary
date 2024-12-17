import Foundation
internal import LocalizationTable

public extension LocalizedStringResource {
	static let libraryLayoutPicker = LibraryLayoutPicker.self

	enum LibraryLayoutPicker {
		private static let localizationTable = LocalizationTableResource("LibraryLayoutPicker", bundle: .module)

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		public enum Item {
			public static let list = LocalizedStringResource("ITEM.LIST", table: localizationTable)
			public static let grid = LocalizedStringResource("ITEM.GRID", table: localizationTable)
		}
	}
}
