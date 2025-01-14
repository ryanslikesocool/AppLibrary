import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let developedWithLove = DevelopedWithLove.self

	/// ## Topics
	/// - ``developedWithLove``
	enum DevelopedWithLove {
		private static let localizationTable = LocalizationTableResource("DevelopedWithLove")

		public static let developer = LocalizedStringResource("DEVELOPER", table: localizationTable)
		public static let location = LocalizedStringResource("LOCATION", table: localizationTable)
	}
}
