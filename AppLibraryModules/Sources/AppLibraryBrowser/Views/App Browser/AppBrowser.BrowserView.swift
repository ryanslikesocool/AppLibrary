import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

extension AppBrowser {
	struct BrowserView: View {
		@Environment(\.libraryLayout) private var libraryLayout

		@ObservedObject private var browserModel: BrowserModel = .shared
		@ObservedObject private var appSettings: AppSettings = .shared

		private var displayingApps: [Application] { browserModel.filteredApps }

		var body: some View {
			ScrollViewReader { proxy in
				ScrollView(.vertical) {
					scrollContent
				}
				.frame(maxWidth: .infinity)
				.buttonStyle(.plain)
				.scrollClipDisabled()
				.padding(.top, LibraryLayout.list.iconSize + LibraryLayout.list.padding * 0.5)
				.padding(.bottom, LibraryLayout.list.padding)
				.onReceive(Event.scrollToApp) { id in
					onScrollToApp(id: id, proxy: proxy)
				}
			}
		}
	}
}

// MARK: - Supporting Views

private extension AppBrowser.BrowserView {
	@ViewBuilder var scrollContent: some View {
		if browserModel.searchQuery.isEmpty {
			switch libraryLayout {
				case .list: AppBrowser.ListView(apps: displayingApps)
				case .grid: AppBrowser.GridView(apps: displayingApps)
			}
		} else {
			AppBrowser.ListView(apps: displayingApps)
		}
	}
}

// MARK: - Event Receivers

private extension AppBrowser.BrowserView {
	func onScrollToApp(id: ApplicationIdentifier, proxy: ScrollViewProxy) {
		withAnimation(appSettings.display.willReduceMotion ? nil : .default) {
			proxy.scrollTo(id, anchor: .top)
		}
	}
}
