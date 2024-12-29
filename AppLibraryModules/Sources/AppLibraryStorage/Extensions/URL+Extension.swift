import AppLibraryCommon
import Foundation

extension URL {
	// VALIDATE: Does "Preferences" need to be localized?
	static let preferencesDirectory: Self = Self.libraryDirectory
		.appending(path: "Preferences", directoryHint: .isDirectory)

	static let settingsDirectory: Self = Self.preferencesDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)

	init(for category: SettingsCategory) {
		self = Self.settingsDirectory
			.appending(component: "\(category.rawValue).plist", directoryHint: .notDirectory)
	}
}
