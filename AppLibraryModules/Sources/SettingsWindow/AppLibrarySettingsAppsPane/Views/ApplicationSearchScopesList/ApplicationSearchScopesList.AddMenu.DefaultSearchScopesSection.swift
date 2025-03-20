import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension ApplicationSearchScopesList.AddMenu {
	struct DefaultSearchScopesSection: View {
		@Environment(ApplicationSearchScopesEditorViewModel.self) private var viewModel
		@Storage(apps: \.searchScopes) private var searchScopes

		public init() { }

		public var body: some View {
			Section {
				ForEach(
					[URL].defaultSearchScopes, id: \.self,
					content: makeItem
				)
			} header: {
				Text(.applicationSearchScopesList.addMenu.defaultSectionTitle)
			}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesList.AddMenu.DefaultSearchScopesSection {
	func makeItem(for url: URL) -> some View {
		Button {
			viewModel.addSearchScope(url)
		} label: {
			URLLabel(url)
		}
		.disabled(searchScopes.contains(url))
	}
}
