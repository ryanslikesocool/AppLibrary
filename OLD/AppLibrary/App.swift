import ALSettings
import SwiftUI

@main struct App: SwiftUI.App {
	@Environment(\.scenePhase) private var scenePhase
	@NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

	@StateObject private var settings: AppSettings = AppSettings.shared

	var body: some Scene {
		MenuBarExtra("App Library", systemImage: "square.grid.3x3.fill") {
			ContentView()
				.environmentObject(appDelegate)
		}
		.menuBarExtraStyle(.window)
		.windowResizability(.contentSize)

		SettingsScene(settings: settings)
	}
}
