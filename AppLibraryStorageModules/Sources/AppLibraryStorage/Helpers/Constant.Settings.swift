import AppLibraryCommon
import Foundation

public extension Constant {
	enum Settings {
		static let settingsDirectoryURL: URL = Constant.applicationSupportDirectory
			.appending(components: "settings", directoryHint: .isDirectory)

		public static let defaultSearchScopes: [URL] = [
			"/System/Applications",
			"/System/Library/CoreServices/Applications",
			"/Applications",
			"~/Applications",
		]
		.sorted(using: .localizedStandard)
		.map { filePath in
			URL(filePath: filePath, directoryHint: .isDirectory)
		}

		public static let defaultApplicationVisibility: [ApplicationIdentifier: ApplicationHideFlag.Set] = [
			ApplicationIdentifier(Bundle.main.bundleIdentifier!, named: "App Library"): .all,
		]
	}
}
