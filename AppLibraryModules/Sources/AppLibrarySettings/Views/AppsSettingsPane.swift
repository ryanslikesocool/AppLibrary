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
					let text: String = model.hiddenApps[index]
					LabeledContent {
						Button("Show") { model.removeHiddenApp(at: index) }
					} label: {
						Text(text)
							.lineLimit(1)
							.truncationMode(.tail)
							.help(text)
					}
				}
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
