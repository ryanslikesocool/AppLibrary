import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let openAtLoginToggle = OpenAtLoginToggle.self

	/// ## Topics
	/// - ``openAtLoginToggle``
	enum OpenAtLoginToggle {
		private static let localizationTable = LocalizationTableResource("OpenAtLoginToggle")

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)
	}
}
