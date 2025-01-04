internal import LocalizationToolbox
import BundleToolbox
import Foundation

public extension LocalizedStringResource {
	static let browserWindow = BrowserWindow.self

	enum BrowserWindow {
		private static let localizationTable = LocalizationTableResource("BrowserWindow")

		private static let titleFormat = LocalizedStringResource("TITLE_%@", table: localizationTable)

		/// - Parameter applicationName: The name of the application.
		public static func title(applicationName: String) -> String {
			var options = String.LocalizationOptions()
			options.replacements = [applicationName]

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
