import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var settingsWindow: SettingsWindow.Type { SettingsWindow.self }

	/// ## Topics
	/// - ``settingsWindow``
	enum SettingsWindow {
		private static let localizationTable = LocalizationTableResource("SettingsWindow")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
	}
}
