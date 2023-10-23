import SwiftUI

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = AppSettings.shared

	var body: some View {
		TabView {
			DisplaySettingsPane(model: $appSettings.display)
			DirectoriesSettingsPane(model: $appSettings.directories)
			AppsSettingsPane(model: $appSettings.apps)
		}

		.frame(width: 450)
		.fixedSize()
		.formStyle(.grouped)
	}
}
