import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct DiscoveryPane: SettingsPaneView {
	static var tab: SettingsTab { .discovery }

	@Binding var model: AppSettings.Discovery

	var content: some View {
		refreshButton
		SearchScopeList(model: $model)
	}
}

private extension DiscoveryPane {
	var refreshButton: some View {
		LabeledContent {
			Button("Refresh", systemImage: "arrow.clockwise", action: Event.refreshApps.send)
		} label: {
			Text("Refresh Library")
			Text("Use ⌘ + R to refresh the list while the Library is focused.")
		}
	}
}
