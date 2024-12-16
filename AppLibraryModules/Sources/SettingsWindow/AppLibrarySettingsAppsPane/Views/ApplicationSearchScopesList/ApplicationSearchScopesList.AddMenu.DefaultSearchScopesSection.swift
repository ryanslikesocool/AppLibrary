import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension ApplicationSearchScopesList.AddMenu {
	struct DefaultSearchScopesSection: View {
		@Storage(locations: \.searchScopes) private var searchScopes

		private let addSearchScope: (URL) -> Void

		public init(addSearchScope: @escaping (URL) -> Void) {
			self.addSearchScope = addSearchScope
		}

		public var body: some View {
			Section {
				ForEach(Constant.Settings.defaultSearchScopes, id: \.self, content: makeItem)
			} header: {
				Text(.applicationSearchScopesList.addMenu.defaultSectionTitle, table: .applicationSearchScopesList)
			}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesList.AddMenu.DefaultSearchScopesSection {
	func makeItem(for url: URL) -> some View {
		Button {
			addSearchScope(url)
		} label: {
			URLLabel(url)
		}
		.disabled(searchScopes.contains(url))
	}
}
