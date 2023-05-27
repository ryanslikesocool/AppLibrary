import Settings
import SwiftUI

struct DisplaySettingsPane: View {
	@ObservedObject private var settings: AppSettings = .shared

	var body: some View {
		Settings.Container(contentWidth: 300.0, minimumLabelWidth: 0) {
			Settings.Section(title: "") {
				Picker("Appearance", selection: $settings.display.appearance) {
					Text("System").tag(AppSettings.Display.Appearance.system)
					Divider()
					Text("Light").tag(AppSettings.Display.Appearance.light)
					Text("Dark").tag(AppSettings.Display.Appearance.dark)
				}
				.onChange(of: settings.display.appearance) { $0.apply() }

				Toggle("Active in Dock", isOn: $settings.display.activeInDock)
					.help("Should App Library display an app icon indicator?")
					.onChange(of: settings.display.activeInDock) { _ in settings.display.apply() }
			}
		}
	}
}
