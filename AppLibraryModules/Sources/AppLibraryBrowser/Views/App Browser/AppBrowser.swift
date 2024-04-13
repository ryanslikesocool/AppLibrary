import AppLibraryStorage
import OSLog
import SwiftUI

struct AppBrowser: View {
	@Environment(\.libraryLayout) private var libraryLayout
	@ObservedObject private var browserModel: BrowserModel = .shared
	@ObservedObject private var appSettings: AppSettings = .shared

	private var displayingApps: [Application] { browserModel.filteredApps }

	var body: some View {
		switch browserModel.queryState {
			case .some(.loading): queryLoadingView
			case .some(.complete): queryCompleteView
			case let .some(.failed(reason)): queryFailedView(reason: reason)
			case .none: EmptyView()
		}
	}
}

// MARK: - Supporting Views

private extension AppBrowser {
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
		.foregroundStyle(.secondary)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}

	var queryCompleteView: some View {
		ScrollViewReader { proxy in
			ScrollView(.vertical) {
				if browserModel.searchQuery.isEmpty {
					switch libraryLayout {
						case .list: ListView(apps: displayingApps)
						case .grid: GridView(apps: displayingApps)
					}
				} else {
					ListView(apps: displayingApps)
				}
			}
			.frame(maxWidth: .infinity)
			.buttonStyle(.plain)
			.scrollClipDisabled()
			.padding(.top, LibraryLayout.list.iconSize + LibraryLayout.list.padding * 0.5)
			.padding(.bottom, LibraryLayout.list.padding)
			.onReceive(Event.Publisher.scrollToApp) { notification in
				onScrollToApp(notification: notification, proxy: proxy)
			}
		}
	}
}

// MARK: - Event Receivers

private extension AppBrowser {
	func onScrollToApp(notification: Notification, proxy: ScrollViewProxy) {
		guard let id = notification.userInfo?.values.first as? ApplicationIdentifier else {
			return
		}
		withAnimation(appSettings.display.willReduceMotion ? nil : .default) {
			proxy.scrollTo(id, anchor: .top)
		}
	}
}
