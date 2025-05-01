import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var settingsWindow: SettingsWindow.Type { SettingsWindow.self }

	/// ## Topics
	/// - ``settingsWindow``
	enum SettingsWindow {
		private static let localizationTable = LocalizationTableResource("SettingsWindow")

		@available(*, deprecated)
		public static var category: Category.Type { Category.self }

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``category``
		@available(*, deprecated)
		public enum Category {
			public static var apps: Apps.Type { Apps.self }
			public static var general: General.Type { General.self }
			public static var layout: Layout.Type { Layout.self }

			/// ## Topics
			/// - ``apps``
			public enum Apps {
				public static let title = LocalizedStringResource("CATEGORY.APPS.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``general``
			public enum General {
				public static let title = LocalizedStringResource("CATEGORY.GENERAL.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``layout``
			public enum Layout {
				public static let title = LocalizedStringResource("CATEGORY.LAYOUT.TITLE", table: localizationTable)
			}
		}
	}
}
