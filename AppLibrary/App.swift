import SwiftUI

@main struct App: SwiftUI.App {
	@Environment(\.scenePhase) private var scenePhase
	@NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

	var body: some Scene {
		Window("App Library", id: "appLibrary") {
			ContentView()
				.environmentObject(appDelegate)
		}
		.windowResizability(.contentSize)
		.onChange(of: scenePhase, perform: phaseChanged)

		SettingsScene(delegate: appDelegate)
	}

	private func phaseChanged(phase: ScenePhase) {
		switch phase {
			case .active:
				appDelegate.state.load()
			case .background:
				appDelegate.state.unload()
			default:
				break
		}
	}
}
