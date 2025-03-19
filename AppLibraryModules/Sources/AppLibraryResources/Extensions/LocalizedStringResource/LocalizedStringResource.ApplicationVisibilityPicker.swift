import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var applicationVisibilityPicker: ApplicationVisibilityPicker.Type { ApplicationVisibilityPicker.self }

	/// ## Topics
	/// - ``applicationVisibilityPicker``
	enum ApplicationVisibilityPicker {
		private static let localizationTable = LocalizationTableResource("ApplicationVisibilityPicker")

		public static var item: Item.Type { Item.self }

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		public static let description = LocalizedStringResource("DESCRIPTION_\(String(localized: .common.action.hide))", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let browser = LocalizedStringResource("ITEM.BROWSER_\(LocalizedStringResource.browserWindow.title)", table: localizationTable)
			public static let searchResults = LocalizedStringResource("ITEM.SEARCH_RESULTS", table: localizationTable)
		}
	}
}
