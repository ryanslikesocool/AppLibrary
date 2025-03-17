import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var applicationRefresh: ApplicationRefresh.Type { ApplicationRefresh.self }

	/// ## Topics
	/// - ``applicationRefresh``
	enum ApplicationRefresh {
		private static let localizationTable = LocalizationTableResource("ApplicationRefresh")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)
	}
}
