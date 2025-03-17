import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var openAtLoginToggle: OpenAtLoginToggle.Type { OpenAtLoginToggle.self }

	/// ## Topics
	/// - ``openAtLoginToggle``
	enum OpenAtLoginToggle {
		private static let localizationTable = LocalizationTableResource("OpenAtLoginToggle")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
	}
}
