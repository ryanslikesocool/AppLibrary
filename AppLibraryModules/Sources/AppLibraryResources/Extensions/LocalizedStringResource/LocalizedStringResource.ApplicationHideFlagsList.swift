internal import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let applicationHideFlagsList = ApplicationHideFlagsList.self

	enum ApplicationHideFlagsList {
		private static let localizationTable = LocalizationTableResource("ApplicationHideFlagsList")

		public static let item = Item.self
		public static let form = Form.self
		public static let list = List.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		public enum Item {
			public static let format = Format.self

			public static let notHidden = LocalizedStringResource("ITEM.NOT_HIDDEN", table: localizationTable)
			public static let browser = LocalizedStringResource("ITEM.BROWSER", table: localizationTable)
			public static let search = LocalizedStringResource("ITEM.SEARCH", table: localizationTable)

			public enum Format {
				private static let verbFormat = LocalizedStringResource("ITEM.FORMAT.VERB_\(placeholder: .object)", table: localizationTable)
				private static let adjectiveFormat = LocalizedStringResource("ITEM.FORMAT.ADJECTIVE_\(placeholder: .object)", table: localizationTable)

				public static func verb(_ argument: some CVarArg) -> String {
					let options = String.LocalizationOptions(replacements: argument)
					return String(localized: verbFormat, options: options)
				}

				public static func adjective(_ argument: some CVarArg) -> String {
					let options = String.LocalizationOptions(replacements: argument)
					return String(localized: adjectiveFormat, options: options)
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
