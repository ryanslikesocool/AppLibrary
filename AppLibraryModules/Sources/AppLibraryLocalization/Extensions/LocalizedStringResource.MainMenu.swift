import Foundation
internal import LocalizationTable

public extension LocalizedStringResource {
	static let mainMenu = MainMenu.self

	enum MainMenu {
		private static let localizationTable = LocalizationTableResource("MainMenu")

		public static let submenu = Submenu.self
		public static let item = Item.self

		public enum Submenu {
			public static let edit = LocalizedStringResource("SUBMENU.EDIT", table: localizationTable)
			public static let view = LocalizedStringResource("SUBMENU.VIEW", table: localizationTable)
		}

		public enum Item {
			public static let refresh = LocalizedStringResource("ITEM.REFRESH", table: localizationTable)
			public static let search = LocalizedStringResource("ITEM.SEARCH", table: localizationTable)
		}
	}
}