import AppLibraryCommon
import Foundation

public extension Constant {
	enum Settings {
		static let settingsDirectoryURL: URL = Constant.applicationSupportDirectory
			.appending(components: "settings", directoryHint: .isDirectory)

		public static let defaultSearchScopes: [URL] = [
			URL(filePath: "/System/Applications", directoryHint: .isDirectory),
			URL(filePath: "/System/Library/CoreServices/Applications", directoryHint: .isDirectory),
			URL(filePath: "/Applications", directoryHint: .isDirectory),
			URL(filePath: "~/Applications", directoryHint: .isDirectory),
		]

		public static let defaultApplicationVisibility: [ApplicationIdentifier: ApplicationHideFlags] = [
			ApplicationIdentifier(Bundle.main.bundleIdentifier!, named: "App Library"): .all,
		]
	}
}
