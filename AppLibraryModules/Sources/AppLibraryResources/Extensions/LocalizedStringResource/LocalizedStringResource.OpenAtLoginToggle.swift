import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	@available(*, deprecated)
	static var openAtLoginToggle: OpenAtLoginToggle.Type { OpenAtLoginToggle.self }

	/// ## Topics
	/// - ``openAtLoginToggle``
	@available(*, deprecated)
	enum OpenAtLoginToggle {
		private static let localizationTable = LocalizationTableResource("OpenAtLoginToggle")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
	}
}
