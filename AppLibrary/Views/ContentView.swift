import SwiftUI

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = .shared
	@ObservedObject private var windowController: AppLibraryWindowController
	@State private var searchQuery: String = ""

	init(windowController: AppLibraryWindowController) {
		self.windowController = windowController
	}

	private var filteredApps: [ApplicationInformation] {
		let query: String = searchQuery.lowercased()

		return windowController.apps
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
			if windowController.apps.isEmpty {
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
			if windowController.apps.isEmpty {
				NotificationCenter.default.post(name: AppLibraryWindowController.reloadApps, object: nil)
			}
		}
	}
}
