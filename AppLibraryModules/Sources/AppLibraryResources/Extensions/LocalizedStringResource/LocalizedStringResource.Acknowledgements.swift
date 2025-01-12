import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let acknowledgements = Acknowledgements.self

	enum Acknowledgements {
		private static let localizationTable = LocalizationTableResource("Acknowledgements")

		public static let link = Link.self
		public static let section = Section.self

		public enum Link {
			public static let github = LocalizedStringResource("LINK.GITHUB", table: localizationTable)
			public static let license = LocalizedStringResource("LINK.LICENSE", table: localizationTable)
			public static let personal = LocalizedStringResource("LINK.PERSONAL", table: localizationTable)
			public static let project = LocalizedStringResource("LINK.PROJECT", table: localizationTable)
		}

		public enum Section {
			public static let title = LocalizedStringResource("SECTION.TITLE", table: localizationTable)
		}
	}
}
