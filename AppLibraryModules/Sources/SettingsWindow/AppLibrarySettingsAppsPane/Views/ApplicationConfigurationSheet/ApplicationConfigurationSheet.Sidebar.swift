import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension ApplicationConfigurationSheet {
	struct Sidebar: View {
		@Binding private var searchQuery: String
		@Binding private var selection: ApplicationModelIdentifier?

		public init(selection: Binding<ApplicationModelIdentifier?>, searchQuery: Binding<String>) {
			_searchQuery = searchQuery
			_selection = selection
		}

		public var body: some View {
			List(
				applications,
				selection: $selection,
				rowContent: Item.init(for:)
			)
			.listStyle(.sidebar)
		}
	}
}

// MARK: - Properties

private extension ApplicationConfigurationSheet.Sidebar {
	var applications: [ApplicationModelIdentifier] {
		if searchQuery.isEmpty {
			ApplicationCache.shared.applications.keys
		} else {
			ApplicationCache.shared.applications.values
				.filter { application in
					application.displayName.localizedStandardContains(searchQuery)
				}
				.map(ApplicationModelIdentifier.init(_:))
		}
	}
}