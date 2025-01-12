import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let aboutWindow = AboutWindow.self

	enum AboutWindow {
		private static let localizationTable = LocalizationTableResource("AboutWindow")

		private static let titleFormat = LocalizedStringResource("TITLE_\(placeholder: .object)", table: localizationTable)

		/// - Parameter applicationName: The name of the application.
		public static func title(applicationName: some CVarArg) -> String {
			let options = String.LocalizationOptions(replacements: applicationName)
			return String(localized: titleFormat, options: options)
		}

		public static var title: String! {
			guard let applicationName = try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName) else {
				return nil
			}
			return title(applicationName: applicationName)
		}
	}
}
