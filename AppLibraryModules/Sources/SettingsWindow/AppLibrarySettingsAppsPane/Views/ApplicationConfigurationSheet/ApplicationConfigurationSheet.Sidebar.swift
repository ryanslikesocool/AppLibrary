import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftData
import SwiftUI

extension ApplicationConfigurationSheet {
	struct Sidebar: View {
		@State private var searchQuery: String = ""

		public init() { }

		public var body: some View {
			ListContent(searchQuery: searchQuery)
				.listStyle(.sidebar)

				.safeAreaInset(edge: .top, spacing: 0) {
					NSSearchFieldRepresentable(string: $searchQuery)
						.padding(8)
						.safeAreaInset(edge: .bottom, spacing: 0, content: Divider.init)
				}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationConfigurationSheet.Sidebar {
	struct ListContent: View {
		@Environment(\.modelContext) private var modelContext
		@Environment(ApplicationConfigurationEditorViewModel.self) private var viewModel
		@Query private var applications: [ApplicationModel]

		fileprivate init(searchQuery: String) {
			let predicate: Predicate<ApplicationModel>?
			if searchQuery.isEmpty {
				predicate = nil
			} else {
				predicate = #Predicate<ApplicationModel> { applicationModel in
					applicationModel.displayName.localizedStandardContains(searchQuery)
				}
			}

			let sortDescriptors: [SortDescriptor<ApplicationModel>] = [
				SortDescriptor(\.displayName),
			]

			_applications = Query(
				filter: predicate,
				sort: sortDescriptors
			)
		}

		public var body: some View {
			@Bindable var viewModel = self.viewModel

			List(
				applications,
				selection: $viewModel.selection,
				rowContent: ApplicationLabel.init(for:)
			)
			.contextMenu(forSelectionType: ApplicationModel.ID.self) { selections in
				ContextMenu(for: selections, in: modelContext)
			}
		}
	}
}
