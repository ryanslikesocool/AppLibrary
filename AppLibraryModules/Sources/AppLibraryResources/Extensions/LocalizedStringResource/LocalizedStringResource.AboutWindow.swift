import Foundation
internal import LocalizationToolbox

public extension LocalizedStringResource {
	static let aboutWindow = AboutWindow.self

	enum AboutWindow {
		private static let localizationTable = LocalizationTableResource("AboutWindow")

		public static var title: LocalizedStringResource! {
			guard let applicationName = try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName) else {
				return nil
			}
			return LocalizedStringResource("TITLE_\(applicationName)", table: localizationTable)
		}
	}
}