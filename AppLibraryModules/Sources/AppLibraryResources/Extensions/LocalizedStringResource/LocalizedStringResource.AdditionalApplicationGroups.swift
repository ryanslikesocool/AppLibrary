import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var additionalApplicationGroups: AdditionalApplicationGroups.Type { AdditionalApplicationGroups.self }

	/// ## Topics
	/// - ``additionalApplicationGroups``
	enum AdditionalApplicationGroups {
		private static let localizationTable = LocalizationTableResource("AdditionalApplicationGroups")

		public static var section: Section.Type { Section.self }

		/// ## Topics
		/// - ``section``
		public enum Section {
			public static let title = LocalizedStringResource("SECTION.TITLE", table: localizationTable)
			public static let description = LocalizedStringResource("SECTION.DESCRIPTION", table: localizationTable)
		}
	}
}
