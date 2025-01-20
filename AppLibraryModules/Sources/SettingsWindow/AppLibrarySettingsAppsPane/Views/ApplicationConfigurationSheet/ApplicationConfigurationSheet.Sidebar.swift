import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension ApplicationConfigurationSheet {
	struct Sidebar: View {
		@State private var searchQuery: String = ""

		public init() {		}

		public var body: some View {
			List(
				applications,
				rowContent: Item.init(for:)
			)
			.listStyle(.sidebar)
			.searchable(text: $searchQuery, placement: .sidebar)
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
