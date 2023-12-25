import SwiftUI

struct DirectoriesSettingsPane: SettingsPaneView {
	@Binding var model: AppSettings.Directories
	@State private var showDirectoryPicker: Bool = false

	var content: some View {
		searchScopesSection
	}
}

// MARK: - SettingsPaneView

extension DirectoriesSettingsPane {
	var tabLabel: Label<Text, Image> {
		Label("Directories", systemImage: "folder")
	}
}

// MARK: - Supporting Views

private extension DirectoriesSettingsPane {
	var searchScopesSection: some View {
		Section {
			if model.searchScopes.isEmpty {
				Text("No search directories...")
			} else {
				ForEach(model.searchScopes.indices, id: \.self) { index in
					LabeledContent(model.searchScopes[index].path(percentEncoded: false)) {
						Button(action: { model.removeSearchScope(at: index) }) {
							Image(systemName: "minus")
						}
					}
				}
				.controlSize(.small)
			}
		} header: {
			Text("Search Directories")
			Text("App Library will look for apps in these directories.")
		} footer: {
			Button(action: { showDirectoryPicker = true }) {
				Image(systemName: "plus")
			}
		}
		.fileImporter(isPresented: $showDirectoryPicker, allowedContentTypes: [.folder], onCompletion: completeDirectorySelection)
	}
}

// MARK: - Actions

private extension DirectoriesSettingsPane {
	func completeDirectorySelection(_ result: Result<URL, Error>) {
		switch result {
			case let .success(url): model.tryAdd(searchScope: url)
			case let .failure(error): print(error)
		}
	}
}
