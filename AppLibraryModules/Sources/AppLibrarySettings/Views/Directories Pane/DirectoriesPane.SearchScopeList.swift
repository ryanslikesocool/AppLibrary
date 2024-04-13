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

	private func listElement(for searchScope: String) -> some View {
		return LabeledContent {
			Menu("Options", systemImage: "ellipsis.circle") {
				optionMenuContent(for: searchScope)
			}
			.labelStyle(.iconOnly)
			.fixedSize()
			.menuIndicator(.hidden)
			.buttonStyle(.plain)
		} label: {
			Text(searchScope)
				.lineLimit(1)
				.truncationMode(.tail)
				.help(searchScope)
		}
	}

	@ViewBuilder var sectionHeader: some View {
		Text("Search Directories")
		Text("App Library will look for apps in these directories.")
	}

	var sectionFooter: some View {
		Menu("Add Directory", systemImage: "plus",  content: {
			Section {
				Button("Add Custom Directory") { showDirectoryPicker = true }
			}
			Section("Default") {
				ForEach(AppSettings.Directories.defaultSearchScopes.sorted()) { path in
					Button(path) { model.tryAddSearchScope(withPath: path) }
						.disabled(model.searchScopes.contains(path))
				}
			}
		}, primaryAction: {
			showDirectoryPicker = true
		})
		.labelStyle(.iconOnly)
		.fixedSize()
	}

	private func optionMenuContent(for searchScope: String) -> some View {
		Group {
			Section {
				Button("Remove", systemImage: "minus") { model.removeSearchScope(withPath: searchScope) }
			}
			Section {
				Button("Show in Finder", systemImage: "doc") { model.getURL(forPath: searchScope)?.showInFinder() }
			}
		}
		.labelStyle(.titleOnly)
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
