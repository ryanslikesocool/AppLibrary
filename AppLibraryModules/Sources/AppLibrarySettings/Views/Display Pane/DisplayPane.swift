import AppKit
import AppLibraryStorage
import SwiftUI

struct DisplayPane: SettingsPaneView {
	static var tab: SettingsTab { .display }

	@Binding var model: AppSettings.Display

	var content: some View {
		AppearanceSection(model: $model)
		Section {
			libraryLayoutPicker
		}
		GroupingSection(model: $model)
	}
}

// MARK: - Supporting Views

extension DisplayPane {
	var libraryLayoutPicker: some View {
		Picker("Library Layout", selection: $model.libraryLayout) {
			ForEach(LibraryLayout.allCases) { mode in
				Text(mode.description)
					.tag(mode)
			}
		}
	}
}
