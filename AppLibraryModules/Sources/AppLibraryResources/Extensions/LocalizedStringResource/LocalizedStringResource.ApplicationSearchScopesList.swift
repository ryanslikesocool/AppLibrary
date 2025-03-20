import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var applicationSearchScopesList: ApplicationSearchScopesList.Type { ApplicationSearchScopesList.self }

	/// ## Topics
	/// - ``applicationSearchScopesList``
	enum ApplicationSearchScopesList {
		private static let localizationTable = LocalizationTableResource("ApplicationSearchScopesList")

		public static var item: Item.Type { Item.self }
		public static var addMenu: AddMenu.Type { AddMenu.self }
		public static var addDialog: AddDialog.Type { AddDialog.self }
		public static var form: Form.Type { Form.self }
		public static var list: List.Type { List.self }

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let optionsLabel = LocalizedStringResource("ITEM.OPTIONS.LABEL", table: localizationTable)
		}

		/// ## Topics
		/// - ``addMenu``
		public enum AddMenu {
			public static let defaultSectionTitle = LocalizedStringResource("ADD_MENU.DEFAULT_SECTION.TITLE", table: localizationTable)
		}

		/// ## Topics
		/// - ``addDialog``
		public enum AddDialog {
			public static let confirm = LocalizedStringResource("ADD_DIALOG.CONFIRM", table: localizationTable)
			public static let message = LocalizedStringResource("ADD_DIALOG.MESSAGE", table: localizationTable)
		}

		/// ## Topics
		/// - ``form``
		public enum Form {
			public static let description = LocalizedStringResource("FORM.DESCRIPTION", table: localizationTable)
		}

		/// ## Topics
		/// - ``list``
		public enum List {
			public static let description = LocalizedStringResource("LIST.DESCRIPTION", table: localizationTable)
			public static let emptyLabel = LocalizedStringResource("LIST.EMPTY_LABEL", table: localizationTable)
		}
	}
}
