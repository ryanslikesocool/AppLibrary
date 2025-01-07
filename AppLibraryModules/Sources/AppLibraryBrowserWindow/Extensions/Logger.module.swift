import AppLibraryCommon
import OSLog

extension Logger {
	static let module: Self = Self(category: "AppLibraryBrowser")

	static let input: Self = Self(category: "AppLibraryBrowser.Input")
}
