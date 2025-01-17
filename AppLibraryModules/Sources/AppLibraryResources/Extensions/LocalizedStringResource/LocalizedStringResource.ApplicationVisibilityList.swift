import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let applicationVisibilityList = ApplicationVisibilityList.self

	/// ## Topics
	/// - ``applicationVisibilityList``
	enum ApplicationVisibilityList {
		private static let localizationTable = LocalizationTableResource("ApplicationVisibilityList")

		public static let item = Item.self
		public static let form = Form.self
		public static let list = List.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let format = Format.self

			public static let visible = LocalizedStringResource("ITEM.VISIBLE", table: localizationTable)
			public static let hidden = LocalizedStringResource("ITEM.HIDDEN", table: localizationTable)
			public static let browser = LocalizedStringResource("ITEM.BROWSER", table: localizationTable)
			public static let searchResults = LocalizedStringResource("ITEM.SEARCH_RESULTS", table: localizationTable)

			/// ## Topics
			/// - ``format``
			public enum Format {
				private static let verbFormat = LocalizedStringResource("ITEM.FORMAT.VERB_\(placeholder: .object)", table: localizationTable)
				private static let pastParticipleFormat = LocalizedStringResource("ITEM.FORMAT.PAST_PARTICIPLE_\(placeholder: .object)", table: localizationTable)

				public static func verb(_ argument: some CVarArg) -> String {
					let options = String.LocalizationOptions(replacements: argument)
					return String(localized: verbFormat, options: options)
				}

				public static func pastParticiple(_ argument: some CVarArg) -> String {
					let options = String.LocalizationOptions(replacements: argument)
					return String(localized: pastParticipleFormat, options: options)
				}
			}
		}

		/// ## Topics
		/// - ``form``
		public enum Form {
			public static let description = LocalizedStringResource("FORM.DESCRIPTION", table: localizationTable)
		}

		/// ## Topics
		/// - ``list``
		public enum List {
			public static let emptyLabel = LocalizedStringResource("LIST.EMPTY_LABEL", table: localizationTable)
			private static let descriptionFormat = LocalizedStringResource("LIST.DESCRIPTION_\(placeholder: .object)", table: localizationTable)

			public static var description: String {
				let options = String.LocalizationOptions(replacements: [
					String(localized: LocalizedStringResource.common.action.hide),
				])
				return String(localized: descriptionFormat, options: options)
			}
		}
	}
}
