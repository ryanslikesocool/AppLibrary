import Foundation
internal import LocalizationTable

public extension LocalizedStringResource {
	static let applicationSearchScopesList = ApplicationSearchScopesList.self

	enum ApplicationSearchScopesList {
		private static let localizationTable = LocalizationTableResource("ApplicationSearchScopesList")

		public static let item = Item.self
		public static let addMenu = AddMenu.self
		public static let addDialog = AddDialog.self
		public static let form = Form.self
		public static let list = List.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		public enum Item {
			public static let optionsLabel = LocalizedStringResource("ITEM.OPTIONS.LABEL", table: localizationTable)
		}

		public enum AddMenu {
			public static let action = LocalizedStringResource("ADD_MENU.ACTION", table: localizationTable)
			public static let label = LocalizedStringResource("ADD_MENU.LABEL", table: localizationTable)
			public static let defaultSectionTitle = LocalizedStringResource("ADD_MENU.DEFAULT_SECTION.TITLE", table: localizationTable)
		}

		public enum AddDialog {
			public static let confirm = LocalizedStringResource("ADD_DIALOG.CONFIRM", table: localizationTable)
			public static let message = LocalizedStringResource("ADD_DIALOG.MESSAGE", table: localizationTable)
		}

		public enum Form {
			public static let description = LocalizedStringResource("FORM.DESCRIPTION", table: localizationTable)
		}

		public enum List {
			public static let description = LocalizedStringResource("LIST.DESCRIPTION", table: localizationTable)
			public static let emptyLabel = LocalizedStringResource("LIST.EMPTY_LABEL", table: localizationTable)
		}
	}
}
