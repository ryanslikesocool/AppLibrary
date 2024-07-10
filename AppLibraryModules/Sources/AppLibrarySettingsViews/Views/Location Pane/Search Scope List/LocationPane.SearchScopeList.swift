import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

extension LocationPane {
	struct SearchScopeList: View {
		@ObservedObject var model: LocationSettings
		@Binding var selection: Set<URL>
		@State private var showDirectoryPicker: Bool = false

		var body: some View {
			Section {
				if selection.isEmpty {
					emptyListLabel
				} else {
					listContent
				}
			} header: {
				sectionHeader
			} footer: {
				sectionFooter
			}

			.fileImporter(
				isPresented: $showDirectoryPicker,
				allowedContentTypes: [.folder],
				onCompletion: completeFileImporter
			)
			.fileDialogDefaultDirectory(.homeDirectory)
			.fileDialogMessage("Add a Search Scope")
			.fileDialogConfirmationLabel("Select Scope")

			.onChange(of: selection) { Event.refreshApps() }
		}
	}
}

// MARK: - Supporting Views

private extension LocationPane.SearchScopeList {
	var emptyListLabel: some View {
		Text("No search scopes...")
			.foregroundStyle(.secondary)
	}

	var listContent: some View {
		ForEach(selection.sorted()) { item in
			Item(model: model, for: item)
		}
	}

	@ViewBuilder var sectionHeader: some View {
		Text("Search Scopes")
		Text("The Library will look for apps in these directories.")
	}

	var sectionFooter: some View {
		Menu("Add Scope", systemImage: Constant.Symbol.plus, content: {
			Section {
				Button("Add Custom Scope") { showDirectoryPicker = true }
			}
			Section("Default Scopes") {
				ForEach(Constant.Settings.defaultSearchScopes.sorted()) { url in
					Button(url.abbreviatingWithTildeInPath) { model.addSearchScope(at: url) }
						.disabled(model.searchScopes.contains(url))
				}
			}
		}, primaryAction: {
			showDirectoryPicker = true
		})
		.labelStyle(.iconOnly)
		.fixedSize()
	}
}

// MARK: - Functions

private extension LocationPane.SearchScopeList {
	func completeFileImporter(_ result: Result<URL, Error>) {
		switch result {
			case let .failure(error): Logger.module.error("Failed to select new search directory: \(error.localizedDescription)")
			case let .success(url): model.addSearchScope(at: url)
		}
	}
}
