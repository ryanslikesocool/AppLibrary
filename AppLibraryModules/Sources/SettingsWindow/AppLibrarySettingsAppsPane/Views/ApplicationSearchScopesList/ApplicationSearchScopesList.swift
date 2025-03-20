import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationSearchScopesList: View {
	@Environment(ApplicationSearchScopesEditorViewModel.self) private var viewModel
	@Storage(apps: \.searchScopes) private var searchScopes

	public init() { }

	public var body: some View {
		Group {
			if searchScopes.isEmpty {
				Self.makeEmptyListLabel()
			} else {
				makeListContent()
			}
		}
		.onChange(of: searchScopes, onSearchScopesChanged)
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesList {
	func makeListContent() -> some View {
		@Bindable var viewModel = viewModel

		let searchScopes = searchScopes
			.sorted(using: .path())

		return List(
			searchScopes,
			id: \.self,
			selection: $viewModel.selections
		) { url in
			Item(for: url)
				.padding(.vertical, 4)
				.deleteAction {
					viewModel.removeSearchScope(url)
				}
		}
		.contextMenu(forSelectionType: URL.self) { selections in
			ContextMenu(for: selections)
		}
	}

	nonisolated static func makeEmptyListLabel() -> some View {
		Text(.applicationSearchScopesList.list.emptyLabel)
			.foregroundStyle(.secondary)
	}
}

// MARK: - Functions

private extension ApplicationSearchScopesList {
	func onSearchScopesChanged() {
		Event.refreshApps.send()
	}
}
