import AppLibraryStorage
import SwiftUI

struct LayoutPane: SettingsPaneView {
	static var tab: SettingsTab { .layout }

	@Binding var model: AppSettings.Layout

	var content: some View {
		layoutPicker
		GroupingSection(model: $model)
	}
}

// MARK: - Supporting Views

private extension LayoutPane {
	var layoutPicker: some View {
		Picker("Layout", selection: $model.layout) {
			ForEach(LibraryLayout.allCases) { mode in
				Text(mode.description)
					.tag(mode)
			}
		}
	}
}
