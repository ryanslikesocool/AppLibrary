internal import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let applicationRefresh: ApplicationRefresh.Type = ApplicationRefresh.self

	enum ApplicationRefresh {
		private static let localizationTable = LocalizationTableResource("ApplicationRefresh")

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)
	}
}