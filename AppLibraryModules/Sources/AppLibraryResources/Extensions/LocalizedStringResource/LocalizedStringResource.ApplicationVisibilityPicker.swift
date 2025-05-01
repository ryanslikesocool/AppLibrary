import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var applicationVisibilityPicker: ApplicationVisibilityPicker.Type { ApplicationVisibilityPicker.self }

	/// ## Topics
	/// - ``applicationVisibilityPicker``
	enum ApplicationVisibilityPicker {
		private static let localizationTable = LocalizationTableResource("ApplicationVisibilityPicker")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION_\(String(localized: .common.action.hide))", table: localizationTable)
	}
}
