import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

public struct AboutWindow: Scene {
	@StateObject private var model: AboutWindowModel = AboutWindowModel()

	public init() { }

	public var body: some Scene {
		Window(
			LocalizedStringResource.aboutWindow.title,
			id: Self.windowID
		) {
			ContentView()
				.onWindowAppear(perform: applyWindowStyle)
		}
		.defaultPosition(Self.defaultPosition)
		.windowStyle(Self.windowStyle)
		.windowToolbarStyle(Self.windowToolbarStyle)
		.windowResizability(Self.windowResizability)
		.environmentObject(model)
	}
}

// MARK: - Constants

public extension AboutWindow {
	static let windowID: WindowIdentifier = .about
}

private extension AboutWindow {
	static var defaultPosition: UnitPoint { .center }
	static var windowStyle: some WindowStyle { .hiddenTitleBar }
	static var windowToolbarStyle: some WindowToolbarStyle { .unifiedCompact }
	static var windowResizability: WindowResizability { .contentSize }
}

// MARK: - Functions

private extension AboutWindow {
	func applyWindowStyle(nsWindow: NSWindow) {
		nsWindow.isMovableByWindowBackground = true

		deactivateButton(.miniaturizeButton)
		deactivateButton(.zoomButton)

		func deactivateButton(_ buttonType: NSWindow.ButtonType) {
			guard let button = nsWindow.standardWindowButton(buttonType) else {
				return
			}
			button.isEnabled = false
			button.isHidden = true
		}
	}
}
