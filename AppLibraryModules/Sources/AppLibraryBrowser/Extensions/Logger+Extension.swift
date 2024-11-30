import AppLibraryCore
import OSLog

extension Logger {
	static let module: Self = Self(category: "AppLibraryBrowser")
	static let keyboardEvents: Self = Self(category: "AppLibraryBrowser.KeyboardEvents")
}
