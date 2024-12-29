internal import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let applicationGroupSection: ApplicationGroupSection.Type = ApplicationGroupSection.self

	enum ApplicationGroupSection {
		private static let localizationTable = LocalizationTableResource("ApplicationGroupSection")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)
	}
}
