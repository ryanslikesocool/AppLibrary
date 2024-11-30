import AppLibraryCommon
import OSLog

extension Logger {
	static let module: Self = Self(category: "AppLibraryBrowser")
	static let keyboardEvents: Self = Self(category: "AppLibraryBrowser.KeyboardEvents")
	static let dockUtility: Self = Self(category: "DockUtility")
}
