import Foundation
internal import LocalizationTable

public extension LocalizedStringResource {
	static let applicationHideFlagsList = ApplicationHideFlagsList.self

	enum ApplicationHideFlagsList {
		private static let localizationTable = LocalizationTableResource("ApplicationHideFlagsList", bundle: .module)

		public static let item = Item.self
		public static let form = Form.self
		public static let list = List.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		public enum Item {
			public static let format = Format.self

			public static let browser = LocalizedStringResource("ITEM.BROWSER", table: localizationTable)
			public static let search = LocalizedStringResource("ITEM.SEARCH", table: localizationTable)

			public enum Format {
				public static func verb(_ argument: String) -> LocalizedStringResource {
					LocalizedStringResource("ITEM.FORMAT.VERB_\(argument)", table: localizationTable)
				}

				public static func adjective(_ argument: String) -> LocalizedStringResource {
					LocalizedStringResource("ITEM.FORMAT.ADJECTIVE_\(argument)", table: localizationTable)
				}
			}
		}

		public enum Form {
			public static let description = LocalizedStringResource("FORM.DESCRIPTION", table: localizationTable)
		}

		public enum List {
			public static let emptyLabel = LocalizedStringResource("LIST.EMPTY_LABEL", table: localizationTable)
			public static let description = LocalizedStringResource("LIST.DESCRIPTION", table: localizationTable)
		}
	}
}
