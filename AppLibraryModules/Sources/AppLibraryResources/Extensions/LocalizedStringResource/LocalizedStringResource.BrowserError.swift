import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var browserError: BrowserError.Type { BrowserError.self }

	/// ## Topics
	/// - ``browserError``
	enum BrowserError {
		private static let localizationTable = LocalizationTableResource("BrowserError")

		public static var noSearchScopes: NoSearchScopes.Type { NoSearchScopes.self }
		public static var noApplications: NoApplications.Type { NoApplications.self }
		public static var allApplicationsHidden: AllApplicationsHidden.Type { AllApplicationsHidden.self }

		/// ## Topics
		/// - ``noSearchScopes``
		public enum NoSearchScopes {
			public static let description = LocalizedStringResource("NO_SEARCH_SCOPES.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("NO_SEARCH_SCOPES.RECOVERY_SUGGESTION", table: localizationTable)
		}

		/// ## Topics
		/// - ``noApplications``
		public enum NoApplications {
			public static let description = LocalizedStringResource("NO_APPLICATIONS.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("NO_APPLICATIONS.RECOVERY_SUGGESTION", table: localizationTable)
		}

		/// ## Topics
		/// - ``allApplicationsHidden``
		public enum AllApplicationsHidden {
			public static let description = LocalizedStringResource("ALL_APPLICATIONS_HIDDEN.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("ALL_APPLICATIONS_HIDDEN.RECOVERY_SUGGESTION", table: localizationTable)
		}
	}
}
