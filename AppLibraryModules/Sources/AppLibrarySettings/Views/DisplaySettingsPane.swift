import AppKit
import SwiftUI

struct DisplaySettingsPane: SettingsPaneView {
	@Binding var model: AppSettings.Display

	var content: some View {
		appearancePicker
	}
}

// MARK: - SettingsPaneView

extension DisplaySettingsPane {
	var tabLabel: Label<Text, Image> {
		Label("Display", systemImage: "display")
	}
}

// MARK: - Supporting Views

extension DisplaySettingsPane {
	var appearancePicker: some View {
		Picker(selection: $model.appearance) {
			Text(Appearance.system.description).tag(Appearance.system)
			Divider()
			Text(Appearance.light.description).tag(Appearance.light)
			Text(Appearance.dark.description).tag(Appearance.dark)
		} label: {
			Text("Appearance")
		}
		.onChange(of: model.appearance) { newValue in
			NSApp.appearance = newValue.nsApperance
		}
	}
}
