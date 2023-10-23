import SwiftUI

struct AppsSettingsPane: SettingsPaneView {
	@Binding var model: AppSettings.Apps

	var content: some View {
		Text("not implemented")
	}
}

// MARK: - SettingsPaneView

extension AppsSettingsPane {
	var tabLabel: Label<Text, Image> {
		Label("Apps", systemImage: "app")
	}
}

// MARK: - Supporting Views

extension AppsSettingsPane { }
