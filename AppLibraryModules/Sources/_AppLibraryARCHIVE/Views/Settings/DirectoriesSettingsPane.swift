import Settings
import SwiftUI

struct DirectoriesSettingsPane: View {
	@ObservedObject private var settings: AppSettings = .shared
	@State private var selections: Set<URL> = []
	@State private var showFilePicker: Bool = false

	var body: some View {
		Settings.Container(contentWidth: 300.0, minimumLabelWidth: 0) {
			Settings.Section(title: "") {
				Text("Search Scopes")

				List(settings.directories.searchScopes.sorted(by: { $0.path() < $1.path() }), id: \.self, selection: $selections) { scope in
					Text(scope.path())
				}
				.contextMenu(forSelectionType: URL.self) { selections in
					if !selections.isEmpty {
						let labelString = selections.count == 1 ? "Remove Scope" : "Remove Scopes"

						Button(labelString) { removeScopes(selections) }
					} else {
						Button("Add Scope", action: openFilePicker)
					}
				}
				.listStyle(.bordered(alternatesRowBackgrounds: true))
				.frame(height: 300)

				HStack {
					Spacer()
					Button(action: openFilePicker) {
						Image(systemName: "plus")
					}
					.help("Add a new directory to search for apps.")
				}
			}
		}
		.fileImporter(isPresented: $showFilePicker, allowedContentTypes: [.folder], onCompletion: completeFileImport)
		.onChange(of: settings.directories.searchScopes) { _ in NotificationCenter.default.post(name: AppLibraryWindowController.reloadApps, object: nil) }
	}

	private func removeScopes(_ selections: Set<URL>) {
		self.selections.removeAll()
		settings.directories.searchScopes.removeAll(where: { selections.contains($0) })
	}

	private func openFilePicker() {
		showFilePicker = true
	}

	private func completeFileImport(_ result: Result<URL, Error>) {
		switch result {
			case let .success(url): settings.directories.tryAdd(scope: url)
			case let .failure(error): print(error)
		}
	}
}
