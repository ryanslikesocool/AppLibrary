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
				.windowButtons(miniaturize: .hidden, zoom: .hidden)
		}
		.defaultPosition(Self.defaultPosition)
		.windowStyle(Self.windowStyle)
		.windowResizability(Self.windowResizability)
		.commands {
			CommandGroup(replacing: .appInfo) {
				AboutLink()
			}
		}
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
	static var windowResizability: WindowResizability { .contentSize }
}
