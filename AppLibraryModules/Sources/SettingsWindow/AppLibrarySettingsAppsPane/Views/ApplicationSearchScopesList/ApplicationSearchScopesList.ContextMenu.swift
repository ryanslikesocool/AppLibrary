import SwiftUI
import AppLibraryCommonViews

extension ApplicationSearchScopesList {
	struct ContextMenu: View {
		@Environment(ApplicationSearchScopesEditorViewModel.self) private var viewModel
		private let selections: Set<URL>

		public init?(for selections: Set<URL>) {
			guard !selections.isEmpty else {
				return nil
			}
			self.selections = selections
		}

		public var body: some View {
			Section {
				ShowInFinderButton(selections)
			}

			Section {
				RemoveButton()
					.deleteAction {
						viewModel.removeSearchScopes(selections)
					}
			}
		}
	}
}