import SwiftUI

struct DirectoriesSettingsPane: SettingsPaneView {
	@Binding var model: AppSettings.Directories

	var content: some View {
		Text("not implemented")
	}
}

// MARK: - SettingsPaneView

extension DirectoriesSettingsPane {
	var tabLabel: Label<Text, Image> {
		Label("Directories", systemImage: "folder")
	}
}

// MARK: - Supporting Views

extension DirectoriesSettingsPane { }
