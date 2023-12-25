import SwiftUI

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = AppSettings.shared
	@State private var tabSelection: SettingsTab = .display

	var body: some View {
		TabView(selection: $tabSelection) {
			DisplaySettingsPane(model: $appSettings.display)
				.tag(SettingsTab.display)
				.scrollDisabled(true)
			DirectoriesSettingsPane(model: $appSettings.directories)
				.tag(SettingsTab.directories)
			AppsSettingsPane(model: $appSettings.apps)
				.tag(SettingsTab.apps)
		}
		.frame(width: 450)
		.frame(maxHeight: 500)
		.fixedSize()
		.formStyle(.grouped)
	}
}

// MARK: - Supporting Data

private extension ContentView {
	enum SettingsTab: UInt8, Hashable, Identifiable {
		case display
		case directories
		case apps

		var id: UInt8 { rawValue }
	}
}
