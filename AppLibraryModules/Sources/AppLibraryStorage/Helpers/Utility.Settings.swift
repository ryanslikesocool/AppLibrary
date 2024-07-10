import AppLibraryCommon
import Foundation

extension Utility {
	enum Settings {
		static func fileURL(for category: SettingsCategory) -> URL {
			Constant.Settings.settingsDirectoryURL
				.appending(component: "\(category.rawValue).plist", directoryHint: .notDirectory)
		}
	}
}
