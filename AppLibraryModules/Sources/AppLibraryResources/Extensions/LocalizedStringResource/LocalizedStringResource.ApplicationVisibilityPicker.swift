import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let applicationVisibilityPicker = ApplicationVisibilityPicker.self

	/// ## Topics
	/// - ``applicationVisibilityPicker``
	enum ApplicationVisibilityPicker {
		private static let localizationTable = LocalizationTableResource("ApplicationVisibilityPicker")

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		public static let description = LocalizedStringResource("DESCRIPTION_\(String(localized: .common.action.hide))", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let format = Format.self

			public static let browser = LocalizedStringResource("ITEM.BROWSER_\(LocalizedStringResource.browserWindow.title)", table: localizationTable)
			public static let searchResults = LocalizedStringResource("ITEM.SEARCH_RESULTS", table: localizationTable)

			/// ## Topics
			/// - ``format``
			public enum Format {
				private static let adjective = LocalizedStringResource("ITEM.FORMAT.ADJECTIVE_\(placeholder: .object)", table: localizationTable)

				/// - Parameter argument:
				public static func adjective(_ argument: some CVarArg) -> String {
					let options = String.LocalizationOptions(replacements: argument)
					return String(localized: adjective, options: options)
				}

				/// - Parameter argument:
				public static func adjective(_ argument: LocalizedStringResource) -> String {
					let argument = String(localized: argument)
					return adjective(argument)
				}
			}
		}
	}
}