import Settings
import SwiftUI

struct DisplaySettingsPane: View {
	@ObservedObject private var settings: AppSettings = .shared

	var body: some View {
		Settings.Container(contentWidth: 400.0) {
			Settings.Section(title: "wuh") {
				Picker("Appearance", selection: $settings.display.appearance) {
					Text("System").tag(AppSettings.Display.Appearance.system)
					Divider()
					Text("Light").tag(AppSettings.Display.Appearance.light)
					Text("Dark").tag(AppSettings.Display.Appearance.dark)
				}
			}
		}
	}
}
