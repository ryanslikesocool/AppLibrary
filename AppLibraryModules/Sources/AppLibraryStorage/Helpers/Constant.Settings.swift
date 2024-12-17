import AppLibraryCommon
import Foundation

public extension Constant {
	enum Settings {
		// TODO: Should the settings directory actually point to `URL.preferencesDirectory`?
		static let settingsDirectoryURL: URL = Constant.applicationSupportDirectory
			.appending(components: "settings", directoryHint: .isDirectory)

		// VALIDATE: Do these directories need to be localized?
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
//			ApplicationIdentifier(Bundle.main.bundleIdentifier!, version: try? Bundle.main.cfBundleShortVersionString): .all,
			ApplicationIdentifier(Bundle.main.bundleIdentifier!, version: try? Bundle.main.cfBundleShortVersionString, displayName: "App Library"): .all,
		]
	}
}
