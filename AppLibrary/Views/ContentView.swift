import SwiftUI

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = .shared
	@State private var searchQuery: String = ""
	@State private var apps: [ApplicationInformation] = []

	private var filteredApps: [ApplicationInformation] {
		let query: String = searchQuery.lowercased()

		return apps
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
			ScrollView {
				Spacer()
					.frame(height: 52)

				LazyVStack(alignment: .leading, spacing: 0) {
					ForEach(filteredApps) { app in
						ListTile(app: app)
					}
				}

				Spacer()
					.frame(height: 8)
			}
			.scrollIndicators(.never)
			.padding(.horizontal, 8)
		}
		.overlay(alignment: .top) { SearchBar(query: $searchQuery) }
		.ignoresSafeArea()
		.onAppear {
			TileUtilities.listAllApplications(scopes: [URL](AppSettings.shared.directories.searchScopes), onComplete: { metadata in
				apps = metadata.map { ApplicationInformation(metadata: $0) }
			})
		}
	}
}
