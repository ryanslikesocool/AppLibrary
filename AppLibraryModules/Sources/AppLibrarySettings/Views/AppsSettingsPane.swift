import SwiftUI

struct AppsSettingsPane: SettingsPaneView {
	@Binding var model: AppSettings.Apps

	var content: some View {
		hiddenAppsSection
	}
}

// MARK: - SettingsPaneView

extension AppsSettingsPane {
	var tabLabel: Label<Text, Image> {
		Label("Apps", systemImage: "app")
	}
}

// MARK: - Supporting Views

private extension AppsSettingsPane {
	var hiddenAppsSection: some View {
		Section {
			if model.hiddenApps.isEmpty {
				Text("No hidden apps...")
			} else {
				ForEach(model.hiddenApps.indices, id: \.self) { index in
					LabeledContent(model.hiddenApps[index]) {
						Button("Show") { model.removeHiddenApp(at: index) }
					}
				}
				.controlSize(.small)
			}
		} header: {
			Text("Hidden Apps")
			Text("""
			Apps listed here will not appear in the App Library.
			Apps can be hidden by right-clicking on one in the App Library and selecting "Hide".
			""")
		}
	}
}
