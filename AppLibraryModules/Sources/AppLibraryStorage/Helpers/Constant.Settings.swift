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
			"/System/Library/CoreServices",
			"/System/Library/CoreServices/Applications",
//			"/System/Volumes/Preboot/Cryptexes/App/System/Applications",
			"/Applications",
			"~/Applications",
		]
		.sorted(using: .localizedStandard)
		.map { filePath in
			URL(filePath: filePath, directoryHint: .isDirectory)
		}

		public static let defaultApplicationVisibility: [ApplicationModelIdentifier: ApplicationHideFlag.Set] = [
			ApplicationModelIdentifier(bundleIdentifier: Bundle.main.bundleIdentifier!): .all,
//			ApplicationIdentifier(Bundle.main.bundleIdentifier!, displayName: "App Library"): .all,
		]
	}
}
