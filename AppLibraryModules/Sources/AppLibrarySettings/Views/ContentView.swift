import SwiftUI

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = AppSettings.shared
	@State private var tabSelection: SettingsTab = .display

	var body: some View {
		TabView(selection: $tabSelection) {
			DisplaySettingsPane(model: $appSettings.display)
			DirectoriesSettingsPane(model: $appSettings.directories)
			AppsSettingsPane(model: $appSettings.apps)
		}
		.frame(width: 450)
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
