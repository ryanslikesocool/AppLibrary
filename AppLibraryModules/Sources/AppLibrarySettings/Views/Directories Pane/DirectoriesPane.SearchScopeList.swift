import AppLibraryStorage
import OSLog
import SwiftUI

extension DirectoriesPane {
	struct SearchScopeList: View {
		@Binding var model: AppSettings.Directories
		@State private var showDirectoryPicker: Bool = false

		var body: some View {
			Section {
				if model.searchScopes.isEmpty {
					emptyListLabel
				} else {
					listContent
				}
			} header: {
				sectionHeader
			} footer: {
				sectionFooter
			}
			.fileImporter(isPresented: $showDirectoryPicker, allowedContentTypes: [.folder], onCompletion: completeDirectorySelection)
		}
	}
}

// MARK: - Supporting Views

private extension DirectoriesPane.SearchScopeList {
	var emptyListLabel: some View {
		Text("No search directories...")
			.foregroundStyle(.secondary)
	}

	var listContent: some View {
		ForEach(model.searchScopes.sorted(), content: listElement)
	}

	private func listElement(for searchScope: URL) -> some View {
		let text: String = searchScope.path(percentEncoded: false)

		return LabeledContent {
			Menu("Options", systemImage: "ellipsis.circle") {
				optionMenuContent(for: searchScope)
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

	@ViewBuilder var sectionHeader: some View {
		Text("Search Directories")
		Text("App Library will look for apps in these directories.")
	}

	var sectionFooter: some View {
		Button(action: { showDirectoryPicker = true }) {
			Image(systemName: "plus")
		}
	}

	private func optionMenuContent(for searchScope: URL) -> some View {
		Group {
			Section {
				Button("Remove", systemImage: "minus") { model.removeSearchScope(withURL: searchScope) }
			}
			Section {
				Button("Show in Finder", systemImage: "doc") { searchScope.showInFinder() }
			}
		}
		.labelStyle(.titleAndIcon)
	}
}

// MARK: - Functions

private extension DirectoriesPane.SearchScopeList {
	func completeDirectorySelection(_ result: Result<URL, Error>) {
		switch result {
			case let .success(url): model.tryAddSearchScope(withURL: url)
			case let .failure(error): Logger.module.error("Failed to select new search directory: \(error.localizedDescription)")
		}
	}
}
