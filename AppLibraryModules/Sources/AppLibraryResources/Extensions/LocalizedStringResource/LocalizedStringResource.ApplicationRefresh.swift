import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let applicationRefresh = ApplicationRefresh.self

	/// ## Topics
	/// - ``applicationRefresh``
	enum ApplicationRefresh {
		private static let localizationTable = LocalizationTableResource("ApplicationRefresh")

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)
	}
}
