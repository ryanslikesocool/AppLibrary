import AppLibraryStorage
import SwiftUI

struct DisplayPane: SettingsPaneView {
	static var tab: SettingsTab { .display }

	@Binding var model: AppSettings.Display

	var content: some View {
		AppearanceSection(model: $model)
		AccessibilitySection(model: $model)
	}
}
