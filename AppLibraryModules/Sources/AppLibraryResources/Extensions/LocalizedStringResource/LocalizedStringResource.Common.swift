import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let common = Common.self

	/// ## Topics
	/// - ``common``
	enum Common {
		private static let localizationTable = LocalizationTableResource("Common")

		public static let action = Action.self
		public static let link = Link.self

		/// ## Topics
		/// - ``action``
		public enum Action {
			public static let cancel = LocalizedStringResource("ACTION.CANCEL", table: localizationTable)
			public static let done = LocalizedStringResource("ACTION.DONE", table: localizationTable)
			public static let find = LocalizedStringResource("ACTION.FIND", table: localizationTable)
			public static let hide = LocalizedStringResource("ACTION.HIDE", table: localizationTable)
			public static let open = LocalizedStringResource("ACTION.OPEN", table: localizationTable)
			public static let refresh = LocalizedStringResource("ACTION.REFRESH", table: localizationTable)
			public static let remove = LocalizedStringResource("ACTION.REMOVE", table: localizationTable)
			public static let retry = LocalizedStringResource("ACTION.RETRY", table: localizationTable)
			public static let reveal = LocalizedStringResource("ACTION.REVEAL", table: localizationTable)
			public static let showInFinder = LocalizedStringResource("ACTION.SHOW_IN_FINDER", table: localizationTable)
		}

		/// ## Topics
		/// - ``link``
		public enum Link {
			public static let settings = LocalizedStringResource("LINK.SETTINGS", table: localizationTable)
			public static let manage = LocalizedStringResource("LINK.MANAGE", table: localizationTable)
		}
	}
}
