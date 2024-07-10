import AppLibraryCommon
import OSLog

extension Logger {
	@usableFromInline static let module: Logger = Logger(category: "AppLibraryBrowser")

	@usableFromInline static let keyboardEvents: Logger = Logger(category: "AppLibraryBrowser.KeyboardEvents")
}
