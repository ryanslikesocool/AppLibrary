import Settings
import SwiftUI

struct AppsSettingsPane: View {
	@ObservedObject private var settings: AppSettings = .shared
	@State private var selections: Set<String> = []

	var body: some View {
		Settings.Container(contentWidth: 300.0, minimumLabelWidth: 0) {
			Settings.Section(title: "") {
				Text("Hidden Apps")

				List(settings.directories.hiddenApps.sorted(), id: \.self, selection: $selections) { app in
					Text(app)
				}
				.contextMenu(forSelectionType: String.self) { selections in
					if !selections.isEmpty {
//						Button("Open") { }
//							.disabled(true)
//
//						Divider()
//
//						Button("Show in Finder") { }
//							.disabled(true)

						Button("Reveal in Library") { showApps(selections) }
					}
				}
				.listStyle(.bordered(alternatesRowBackgrounds: true))
				.frame(height: 300)
			}
		}
	}

	private func showApps(_ selections: Set<String>) {
		self.selections.removeAll()
		settings.directories.hiddenApps.removeAll(where: { selections.contains($0) })
	}
}
