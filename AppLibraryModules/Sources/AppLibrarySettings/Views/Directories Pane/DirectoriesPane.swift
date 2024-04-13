import AppLibraryCommon
import AppLibraryStorage
import OSLog
import SwiftUI

struct DirectoriesPane: SettingsPaneView {
	static var tab: SettingsTab { .directories }

	@Binding var model: AppSettings.Directories
	@State private var showDirectoryPicker: Bool = false

	var content: some View {
		searchScopesSection
	}
}

// MARK: - Supporting Views

private extension DirectoriesPane {
	var searchScopesSection: some View {
		Section {
			if model.searchScopes.isEmpty {
				Text("No search directories...")
			} else {
				ForEach(model.searchScopes.indices, id: \.self, content: listElement)
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

	@ViewBuilder private func listElement(index: Int) -> some View {
		let text: String = model.searchScopes[index].path(percentEncoded: false)

		LabeledContent {
			Menu("Options", systemImage: "ellipsis.circle") {
				listElementMenuContent(at: index)
			}
			.labelStyle(.iconOnly)
			.fixedSize()
			.menuIndicator(.hidden)
			.buttonStyle(.plain)
		} label: {
			Text(text)
				.lineLimit(1)
				.truncationMode(.tail)
				.help(text)
		}
	}

	private func listElementMenuContent(at index: Int) -> some View {
		Group {
			Section {
				Button("Remove", systemImage: "minus") { model.removeSearchScope(at: index) }
			}

			Section {
				Button("Show in Finder", systemImage: "doc") { model.searchScopes[index].showInFinder() }
			}
		}
		.labelStyle(.titleAndIcon)
	}
}

// MARK: - Actions

private extension DirectoriesPane {
	func completeDirectorySelection(_ result: Result<URL, Error>) {
		switch result {
			case let .success(url): model.tryAdd(searchScope: url)
			case let .failure(error): Logger.module.error("Failed to select new search directory: \(error.localizedDescription)")
		}
	}
}
