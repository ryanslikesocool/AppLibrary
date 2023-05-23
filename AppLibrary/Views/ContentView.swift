import SwiftUI

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = .shared
	@ObservedObject private var window: AppLibraryWindow
	@State private var searchQuery: String = ""

	init(window: AppLibraryWindow) {
		self.window = window
	}

	private var filteredApps: [ApplicationInformation] {
		let query: String = searchQuery.lowercased()

		return window.apps
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
			if window.apps.isEmpty {
				ProgressView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.opacity(0.333)
			} else {
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
		}
		.overlay(alignment: .top) { SearchBar(query: $searchQuery) }
		.ignoresSafeArea()
		.onAppear { }
	}
}
