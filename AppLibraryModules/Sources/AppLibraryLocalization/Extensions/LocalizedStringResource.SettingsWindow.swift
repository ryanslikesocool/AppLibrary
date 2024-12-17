import Foundation
internal import LocalizationTable

public extension LocalizedStringResource {
	static let settingsWindow = SettingsWindow.self

	enum SettingsWindow {
		private static let localizationTable = LocalizationTableResource("SettingsWindow", bundle: .module)

		public static let category = Category.self

		public enum Category {
			public static let general = LocalizedStringResource("CATEGORY.GENERAL", table: localizationTable)
			public static let layout = LocalizedStringResource("CATEGORY.LAYOUT", table: localizationTable)
			public static let apps = LocalizedStringResource("CATEGORY.APPS", table: localizationTable)
		}
	}
}
