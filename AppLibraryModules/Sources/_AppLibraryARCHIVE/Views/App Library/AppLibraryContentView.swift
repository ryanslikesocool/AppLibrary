import SwiftUI

struct AppLibraryContentView: View {
	@ObservedObject private var state: AppState = .shared
	@ObservedObject private var appSettings: AppSettings = .shared
	@State private var searchQuery: String = ""

	init() { }

	private var filteredApps: [ApplicationInformation] {
		let query: String = searchQuery.lowercased()

		return state.apps
			.filter {
				let initialFilter: Bool = !appSettings.directories.hiddenApps.contains($0.bundleIdentifier)
				let searchFilter: Bool = query.isEmpty || $0.displayName.lowercased().contains(query)
				return initialFilter && searchFilter
			}
			.sorted(by: { $0.displayName < $1.displayName })
			.uniqued()
	}

	var body: some View {
		VStack {
			if state.apps.isEmpty {
				ProgressView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.opacity(0.333)
			} else {
				AppListView(apps: filteredApps)
			}
		}
		.overlay(alignment: .top) { SearchBar(query: $searchQuery) }
		.ignoresSafeArea()
		.onAppear {
			if state.apps.isEmpty {
				NotificationCenter.default.post(name: AppState.reloadApps, object: nil)
			}
		}
	}
}
