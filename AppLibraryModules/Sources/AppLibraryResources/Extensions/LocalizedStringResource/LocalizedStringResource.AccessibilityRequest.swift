import LocalizationToolbox
import Foundation

public extension LocalizedStringResource {
	static let accessibilityRequest = AccessibilityRequest.self

	enum AccessibilityRequest {
		private static let localizationTable = LocalizationTableResource("AccessibilityRequest")

		public static let action = Action.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)

		public enum Action {
			public static let allow = LocalizedStringResource("ACTION.ALLOW", table: localizationTable)
			public static let deny = LocalizedStringResource("ACTION.DENY", table: localizationTable)
		}
	}
}
