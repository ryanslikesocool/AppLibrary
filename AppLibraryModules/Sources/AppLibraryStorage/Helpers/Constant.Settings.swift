import AppLibraryCommon
import Foundation

public extension Constant {
	enum Settings {
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
		]
	}
}
