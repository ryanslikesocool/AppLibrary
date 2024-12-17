import Foundation
internal import LocalizationTable

public extension LocalizedStringResource {
	static let common = Common.self

	enum Common {
		private static let localizationTable = LocalizationTableResource("Common")

		public static let action = Action.self
		public static let browserWindow = BrowserWindow.self
		public static let link = Link.self

		public enum Action {
			public static let cancel = LocalizedStringResource("ACTION.CANCEL", table: localizationTable)
			public static let done = LocalizedStringResource("ACTION.DONE", table: localizationTable)
			public static let refresh = LocalizedStringResource("ACTION.REFRESH", table: localizationTable)
			public static let remove = LocalizedStringResource("ACTION.REMOVE", table: localizationTable)
			public static let retry = LocalizedStringResource("ACTION.RETRY", table: localizationTable)
			public static let reveal = LocalizedStringResource("ACTION.REVEAL", table: localizationTable)
			public static let showInFinder = LocalizedStringResource("ACTION.SHOW_IN_FINDER", table: localizationTable)
		}

		public enum BrowserWindow {
			public static let title = LocalizedStringResource("BROWSER_WINDOW.TITLE", table: localizationTable)
		}

		public enum Link {
			public static let settings = LocalizedStringResource("LINK.SETTINGS", table: localizationTable)
			public static let manage = LocalizedStringResource("LINK.MANAGE", table: localizationTable)
		}
	}
}
