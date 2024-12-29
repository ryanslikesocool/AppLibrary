internal import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let appearancePicker = AppearancePicker.self

	enum AppearancePicker {
		private static let localizationTable = LocalizationTableResource("AppearancePicker")

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		public enum Item {
			public static let light = LocalizedStringResource("ITEM.LIGHT", table: localizationTable)
			public static let dark = LocalizedStringResource("ITEM.DARK", table: localizationTable)
			public static let system = LocalizedStringResource("ITEM.SYSTEM", table: localizationTable)
		}
	}
}
