import SwiftUI

@main struct App: SwiftUI.App {
	@Environment(\.scenePhase) private var scenePhase
	@NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

	var body: some Scene {
		MenuBarExtra("App Library", systemImage: "square.grid.3x3.fill") {
			ContentView()
				.environmentObject(appDelegate)
				.frame(maxHeight: 450)
		}
		.menuBarExtraStyle(.window)
		.windowResizability(.contentSize)

		SettingsScene(delegate: appDelegate)
	}
}
