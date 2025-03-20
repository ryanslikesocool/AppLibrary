import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var common: Common.Type { Common.self }

	/// ## Topics
	/// - ``common``
	enum Common {
		private static let localizationTable = LocalizationTableResource("Common")

		public static var action: Action.Type { Action.self }
		public static var link: Link.Type { Link.self }

		/// ## Topics
		/// - ``action``
		public enum Action {
			public static let add = LocalizedStringResource("ACTION.ADD", table: localizationTable)
			public static let cancel = LocalizedStringResource("ACTION.CANCEL", table: localizationTable)
			public static let done = LocalizedStringResource("ACTION.DONE", table: localizationTable)
			public static let find = LocalizedStringResource("ACTION.FIND", table: localizationTable)
			public static let hide = LocalizedStringResource("ACTION.HIDE", table: localizationTable)
			public static let manage = LocalizedStringResource("ACTION.MANAGE", table: localizationTable)
			public static let open = LocalizedStringResource("ACTION.OPEN", table: localizationTable)
			public static let refresh = LocalizedStringResource("ACTION.REFRESH", table: localizationTable)
			public static let remove = LocalizedStringResource("ACTION.REMOVE", table: localizationTable)
			public static let retry = LocalizedStringResource("ACTION.RETRY", table: localizationTable)
			public static let reveal = LocalizedStringResource("ACTION.REVEAL", table: localizationTable)
			public static let select = LocalizedStringResource("ACTION.SELECT", table: localizationTable)
			public static let showInFinder = LocalizedStringResource("ACTION.SHOW_IN_FINDER", table: localizationTable)
		}

		/// ## Topics
		/// - ``link``
		public enum Link {
			private static let format = LocalizedStringResource("LINK.FORMAT_\(placeholder: .object)", table: localizationTable)

			public static let settings = LocalizedStringResource("LINK.SETTINGS", table: localizationTable)

			public static func format(_ content: String) -> String {
				let options = String.LocalizationOptions(replacements: content)
				return String(localized: format, options: options)
			}

			public static func format(_ content: LocalizedStringResource) -> String {
				let content = String(localized: content)
				return format(content)
			}
		}
	}
}
