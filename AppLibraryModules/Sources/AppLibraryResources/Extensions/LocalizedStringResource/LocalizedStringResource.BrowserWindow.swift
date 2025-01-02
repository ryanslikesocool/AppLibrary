internal import LocalizationToolbox
import BundleToolbox
import Foundation

public extension LocalizedStringResource {
	static let browserWindow = BrowserWindow.self

	enum BrowserWindow {
		private static let localizationTable = LocalizationTableResource("BrowserWindow")

		public static var title: LocalizedStringResource! {
			guard let applicationName = try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName) else {
				return nil
			}
			return LocalizedStringResource("TITLE_\(applicationName)", table: localizationTable)
		}
	}
}
