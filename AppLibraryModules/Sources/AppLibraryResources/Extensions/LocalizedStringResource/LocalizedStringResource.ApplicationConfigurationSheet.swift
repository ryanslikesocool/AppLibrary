import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let applicationConfigurationSheet = ApplicationConfigurationSheet.self

	/// ## Topics
	/// - ``applicationConfigurationSheet``
	enum ApplicationConfigurationSheet {
		private static let localizationTable = LocalizationTableResource("ApplicationConfigurationSheet")

		public static let detail = Detail.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``detail``
		public enum Detail {
			public static let noSelection = LocalizedStringResource("DETAIL.NO_SELECTION", table: localizationTable)
		}
	}
}
