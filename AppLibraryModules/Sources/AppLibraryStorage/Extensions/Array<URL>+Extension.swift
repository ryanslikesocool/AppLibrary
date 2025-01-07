import Foundation

public extension [URL] {
	// VALIDATE: Do these directories need to be localized?
	static let defaultSearchScopes: Self = [
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
}
