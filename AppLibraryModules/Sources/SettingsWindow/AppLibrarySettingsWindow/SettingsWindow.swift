import AppLibraryCommon
import SwiftUI

public struct SettingsWindow: Scene {
	public init() { }

	public var body: some Scene {
		Settings {
			ContentView()
		}
		.windowID(.settings)
	}
}

// MARK: - Constants

public extension SettingsWindow {
	static let windowIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(WindowIdentifier.settings)
}
