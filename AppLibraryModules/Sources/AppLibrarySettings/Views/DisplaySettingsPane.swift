import AppKit
import SwiftUI

struct DisplaySettingsPane: SettingsPaneView {
	@Binding var model: AppSettings.Display

	var content: some View {
		appearancePicker
		appViewPicker
		autoGroupToggle
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
		Picker("Appearance", selection: $model.appearance) {
			Text(Appearance.system.description).tag(Appearance.system)
			Divider()
			Text(Appearance.light.description).tag(Appearance.light)
			Text(Appearance.dark.description).tag(Appearance.dark)
		}
		.onChange(of: model.appearance) { newValue in
			NSApp.appearance = newValue.nsApperance
		}
	}

	var appViewPicker: some View {
		Picker("App View", selection: $model.appView) {
			ForEach(AppViewMode.allCases) { mode in
				Text(mode.description).tag(mode)
			}
		}
		.onChange(of: model.appView) { newValue in
			if newValue == .list {
				model.autoGroup = false
			}
		}
	}

	var autoGroupToggle: some View {
		Toggle(isOn: $model.autoGroup) {
			Text("Auto Group")
			Text("""
			Group apps by category.
			Auto group is only available in Grid App View.
			""")
		}
		.disabled(model.appView == .list)
	}
}
