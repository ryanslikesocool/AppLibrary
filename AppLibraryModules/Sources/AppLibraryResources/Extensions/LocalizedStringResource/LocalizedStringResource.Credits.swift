import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let credits = Credits.self

	enum Credits {
		private static let localizationTable = LocalizationTableResource("Credits")

		public static let link = Link.self
		public static let section = Section.self

		public enum Link {
			public static let github = LocalizedStringResource("LINK.GITHUB", table: localizationTable)
			public static let license = LocalizedStringResource("LINK.LICENSE", table: localizationTable)
			public static let personal = LocalizedStringResource("LINK.PERSONAL", table: localizationTable)
			public static let project = LocalizedStringResource("LINK.PROJECT", table: localizationTable)
		}

		public enum Section {
			public static let acknowledgements = Acknowledgements.self
			public static let contributors = Contributors.self

			public enum Acknowledgements {
				public static let title = LocalizedStringResource("SECTION.ACKNOWLEDGEMENTS.TITLE", table: localizationTable)
			}

			public enum Contributors {
				public static let title = LocalizedStringResource("SECTION.CONTRIBUTORS.TITLE", table: localizationTable)
			}
		}
	}
}
