import Foundation
internal import LocalizationTable

public extension LocalizedStringResource {
	static let browserError = BrowserError.self

	enum BrowserError {
		private static let localizationTable = LocalizationTableResource("BrowserError")

		public static let noSearchScopes = NoSearchScopes.self
		public static let noApplications = NoApplications.self
		public static let allApplicationsHidden = AllApplicationsHidden.self

		public enum NoSearchScopes {
			public static let description = LocalizedStringResource("NO_SEARCH_SCOPES.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("NO_SEARCH_SCOPES.RECOVERY_SUGGESTION", table: localizationTable)
		}

		public enum NoApplications {
			public static let description = LocalizedStringResource("NO_APPLICATIONS.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("NO_APPLICATIONS.RECOVERY_SUGGESTION", table: localizationTable)
		}

		public enum AllApplicationsHidden {
			public static let description = LocalizedStringResource("ALL_APPLICATIONS_HIDDEN.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("ALL_APPLICATIONS_HIDDEN.RECOVERY_SUGGESTION", table: localizationTable)
		}
	}
}
