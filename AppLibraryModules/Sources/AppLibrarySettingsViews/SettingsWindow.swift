import AppLibraryCommon
import SwiftUI

public struct SettingsWindow: Scene {
	public init() { }

	public var body: some Scene {
		Settings {
			ContentView()
		}
	}
}

public extension SettingsWindow {
	static let windowIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("\(AppLibraryInformation.bundleIdentifier!).Settings")
}
