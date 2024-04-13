import SwiftUI

public struct AboutWindow: Scene {
	public init() { }

	public var body: some Scene {
		Window("About", id: Self.windowID) {
			Text("about window")
			Text("not implemented")
		}
		.defaultPosition(.center)
		.windowStyle(.hiddenTitleBar)
		.windowResizability(.contentSize)
	}
}

// MARK: - Constants

public extension AboutWindow {
	static var windowID: String { "about" }
}
