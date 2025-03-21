import Foundation

public extension [URL] {
	// VALIDATE: Do these directories need to be localized?

	// NOTE: Almost all applications in `/System/Library/CoreServices/Applications` are not shown by Launchpad.
	static let defaultSearchScopes: Self = [
		"/System/Applications",
		"/System/Library/CoreServices",
		"/System/Library/CoreServices/Applications",
//		"/System/Volumes/Preboot/Cryptexes/App/System/Applications",
		"/Applications",

		// The "~/Applications" shorthand doesn't play nicely since the app is sandboxed.
		URL.userApplicationDirectory.path(percentEncoded: false),
	]
	.sorted(using: .localizedStandard)
	.map { filePath in
		URL(filePath: filePath, directoryHint: .isDirectory)
	}
}