import SwiftUI
import AppLibraryStorage

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = AppSettings.shared
	@State private var tabSelection: SettingsTab = .display

	var body: some View {
		TabView(selection: $tabSelection) {
			DisplayPane(model: $appSettings.display)
				.tag(SettingsTab.display)
				.scrollDisabled(true)
			DirectoriesPane(model: $appSettings.directories)
				.tag(SettingsTab.directories)
			AppsPane(model: $appSettings.apps)
				.tag(SettingsTab.apps)
		}
		.frame(width: 450)
		.frame(maxHeight: 500)
		.fixedSize()
		.formStyle(.grouped)
	}
}
