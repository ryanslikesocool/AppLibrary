import Foundation

extension URL {
	static let preferencesDirectory: Self = Self.libraryDirectory
		.appending(path: "Preferences", directoryHint: .isDirectory)

	static let settingsDirectory: Self = Self.preferencesDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
}
