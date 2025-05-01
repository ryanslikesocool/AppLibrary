import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var credits: Credits.Type { Credits.self }

	/// ## Topics
	/// - ``credits``
	enum Credits {
		private static let localizationTable = LocalizationTableResource("Credits")

		public static var link: Link.Type { Link.self }

		@available(*, deprecated)
		public static var section: Section.Type { Section.self }

		/// ## Topics
		/// - ``link``
		public enum Link {
			public static var gitHub: GitHub.Type { GitHub.self }
			public static var license: License.Type { License.self }
			public static var personal: Personal.Type { Personal.self }
			public static var project: Project.Type { Project.self }

			/// ## Topics
			/// - ``gitHub``
			public enum GitHub {
				public static let title = LocalizedStringResource("LINK.GITHUB.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``license``
			public enum License {
				public static let title = LocalizedStringResource("LINK.LICENSE.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``personal``
			public enum Personal {
				public static let title = LocalizedStringResource("LINK.PERSONAL.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``project``
			public enum Project {
				public static let title = LocalizedStringResource("LINK.PROJECT.TITLE", table: localizationTable)
			}
		}

		/// ## Topics
		/// - ``section``
		@available(*, deprecated)
		public enum Section {
			public static var acknowledgements: Acknowledgements.Type { Acknowledgements.self }
			public static var contributors: Contributors.Type { Contributors.self }

			/// ## Topics
			/// - ``acknowledgements``
			public enum Acknowledgements {
				public static let title = LocalizedStringResource("SECTION.ACKNOWLEDGEMENTS.TITLE", table: localizationTable)
			}

			/// ## Topics
			/// - ``contributors``
			public enum Contributors {
				public static let title = LocalizedStringResource("SECTION.CONTRIBUTORS.TITLE", table: localizationTable)
			}
		}
	}
}
