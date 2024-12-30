import AppLibraryCommonViews
import SwiftUI

public struct AboutWindow: Scene {
	@StateObject private var model: AboutWindowModel = AboutWindowModel()

	public init() { }

	public var body: some Scene {
		Window("About", id: Self.windowID) {
			Text("about window")
			Text("not implemented")
		}
		.defaultPosition(.center)
		.windowStyle(.hiddenTitleBar)
		.windowResizability(.contentSize)
		.environmentObject(model)
		.commands {
			CommandGroup(replacing: .appInfo) {
				AboutLink()
			}
		}
	}
}

// MARK: - Constants

public extension AboutWindow {
	static let windowID: String = "about"
}
