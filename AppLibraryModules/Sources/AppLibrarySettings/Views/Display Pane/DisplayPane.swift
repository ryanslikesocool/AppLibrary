import AppKit
import AppLibraryStorage
import SwiftUI

struct DisplayPane: SettingsPaneView {
	static var tab: SettingsTab { .display }

	@Binding var model: AppSettings.Display

	var content: some View {
		appearancePicker
		appViewPicker
		autoGroupToggle
	}
}

// MARK: - Supporting Views

extension DisplayPane {
	var appearancePicker: some View {
		Picker("Appearance", selection: $model.appearance) {
			Text(Appearance.system.description).tag(Appearance.system)
			Section {
				Text(Appearance.light.description).tag(Appearance.light)
				Text(Appearance.dark.description).tag(Appearance.dark)
			}
		}
		.onChange(of: model.appearance) {
			NSApp.appearance = model.appearance.nsApperance
		}
	}

	var appViewPicker: some View {
		Picker("App View", selection: $model.appView) {
			ForEach(AppViewMode.allCases) { mode in
				Text(mode.description)
					.tag(mode)
			}
		}
		.onChange(of: model.appView) {
			if model.appView == .list {
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
