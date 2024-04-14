import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = AppSettings.shared
	@State private var tabSelection: SettingsTab = .display

	var body: some View {
		TabView(selection: $tabSelection) {
			DisplayPane(model: $appSettings.display)
				.tag(SettingsTab.display)
			LayoutPane(model: $appSettings.layout)
				.tag(SettingsTab.layout)
			DiscoveryPane(model: $appSettings.discovery)
				.tag(SettingsTab.discovery)
			AppsPane(model: $appSettings.apps)
				.tag(SettingsTab.apps)
		}
		.frame(width: 450)
		.frame(maxHeight: 500)
		.fixedSize()
		.formStyle(.grouped)

		.onReceive(Event.goToSettingsTab) { tab in tabSelection = tab }
	}
}
