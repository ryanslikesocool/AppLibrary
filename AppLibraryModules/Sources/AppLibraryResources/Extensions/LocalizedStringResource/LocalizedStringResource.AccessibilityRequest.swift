import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static var accessibilityRequest: AccessibilityRequest.Type { AccessibilityRequest.self }

	/// ## Topics
	/// - ``accessibilityRequest``
	enum AccessibilityRequest {
		private static let localizationTable = LocalizationTableResource("AccessibilityRequest")

		public static var action: Action.Type { Action.self }

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)

		/// ## Topics
		/// - ``action``
		public enum Action {
			public static let allow = LocalizedStringResource("ACTION.ALLOW", table: localizationTable)
			public static let deny = LocalizedStringResource("ACTION.DENY", table: localizationTable)
		}
	}
}
