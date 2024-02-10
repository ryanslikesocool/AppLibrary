import AppLibrarySettings
import SwiftUI

struct AppList: View {
	@Environment(\.appView) private var appView
	@ObservedObject private var browserCache: BrowserCache = .shared
	@ObservedObject private var appSettings: AppSettings = .shared
//	@State private var appSelection: String? = nil

	var body: some View {
		switch browserCache.queryState {
			case .some(.loading): queryLoadingView
			case .some(.complete): queryCompleteView
			case let .some(.failed(reason)): queryFailedView(reason: reason)
			case .none: EmptyView()
		}
	}
}

private extension AppList {
	func searchFilter(application: Application) -> Bool {
		application.displayName.localizedStandardContains(browserCache.searchQuery)
	}

	func hiddenAppsFilter(application: Application) -> Bool {
		!appSettings.apps.hiddenApps.contains(application.bundleIdentifier)
	}
}

// MARK: - Supporting Views

private extension AppList {
	var queryLoadingView: some View {
		ProgressView()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}

	func queryFailedView(reason error: MetadataQueryError?) -> some View {
		VStack {
			Image(systemName: "exclamationmark.octagon")
				.font(.title)

			switch error {
				case .some(.noSearchDirectories):
					Text("No search directories.")
						.font(.headline)
					Text("Add search directories from the settings pane.")
				default:
					Text("Failed to load apps.")
						.font(.headline)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}

	var queryCompleteView: some View {
		ScrollViewReader { proxy in
			ScrollView(.vertical) {
				if #unavailable(macOS 14) {
					Spacer()
						.frame(height: AppTile.listIconSize + Self.listPadding * 0.5)
				}

				if browserCache.searchQuery.isEmpty {
					let filteredApps = browserCache.apps.filter(hiddenAppsFilter)

					switch appView {
						case .list: listView(filteredApps)
						case .grid: gridView(filteredApps)
					}
				} else {
					let filteredApps = browserCache.apps.filter(hiddenAppsFilter).filter(searchFilter)

					listView(filteredApps)
						.appView(.list)
				}

				if #unavailable(macOS 14) {
					Spacer()
						.frame(height: Self.listPadding)
				}
			}
			.frame(maxWidth: .infinity)
			.buttonStyle(.plain)
			.wrap { view in
				if #available(macOS 14, *) {
					view
						.scrollClipDisabled()
						.padding(.top, AppTile.listIconSize + Self.listPadding * 0.5)
						.padding(.bottom, Self.listPadding)
				} else {
					view
				}
			}
			.onReceive(browserCache.keyboardKeyEventPublisher, perform: { notification in
				guard
					!browserCache.isSearchFocused,
					let string = notification.userInfo?[BrowserCache.eventValueKey] as? String
				else {
					return
				}
				browserCache.jumpTo(string: string, in: proxy)
			})
		}
	}
}

// MARK: - List View

private extension AppList {
	func listView(_ apps: [Application]) -> some View {
		LazyVStack {
			ForEach(apps) { app in
				AppTile(application: app)
			}
		}
		.padding(.horizontal, Self.listPadding)
	}
}

// MARK: - Grid View

private extension AppList {
	func gridView(_ apps: [Application]) -> some View {
		LazyVGrid(columns: Self.gridColumns) {
			ForEach(apps) { app in
				AppTile(application: app)
			}
		}
		.padding(.horizontal, Self.gridPadding)
	}
}

// MARK: - Constants

private extension AppList {
	static let listPadding: Double = 16
	static let gridPadding: Double = 8
	static let gridColumns: [GridItem] = [GridItem](repeating: GridItem(), count: 4)
}