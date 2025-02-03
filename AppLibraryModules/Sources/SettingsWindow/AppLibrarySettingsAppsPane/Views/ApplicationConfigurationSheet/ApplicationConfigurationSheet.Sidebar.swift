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
				.searchable(text: $searchQuery, placement: .sidebar)

//			.safeAreaInset(edge: .top, spacing: nil) {
//				NSSearchFieldRepresentable(string: $searchQuery)
//					.padding()
//			}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationConfigurationSheet.Sidebar {
	struct ListContent: View {
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
			List(
				applications,
				rowContent: Item.init(for:)
			)
		}
	}
}