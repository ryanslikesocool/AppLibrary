import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct LibraryView: View {
	@Environment(\.libraryLayout) private var libraryLayout

	@ObservedObject private var browserModel: BrowserModel = .shared
	@ObservedObject private var appSettings: AppSettings = .shared

	var body: some View {
		ScrollViewReader { proxy in
			ScrollView(.vertical) {
				scrollContent
					.padding(.horizontal, libraryLayout.padding)
			}
			.frame(maxWidth: .infinity)
			.buttonStyle(.plain)
			.scrollClipDisabled()
			.padding(.top, LibraryLayout.list.iconSize + LibraryLayout.list.padding * 0.5)
			.padding(.bottom, LibraryLayout.list.padding)
			.onReceive(Event.scrollToApp) { id in
				scrollToApp(id: id, in: proxy)
			}
			.onChange(of: browserModel.focusedIndex) { _, newValue in
				scrollToApp(index: newValue, in: proxy)
			}
		}
	}
}

// MARK: - Supporting Views

private extension LibraryView {
	@ViewBuilder var scrollContent: some View {
		if browserModel.searchQuery.isEmpty {
			switch libraryLayout {
				case .list: ListView()
				case .grid: GridView()
			}
		} else {
			ListView()
		}
	}
}

// MARK: - Event Receivers

private extension LibraryView {
	func scrollToApp(id: ApplicationIdentifier, in proxy: ScrollViewProxy) {
		withAnimation(appSettings.display.willReduceMotion ? nil : .default) {
			proxy.scrollTo(id, anchor: .top)
		}
	}

	func scrollToApp(index: Int?, in proxy: ScrollViewProxy) {
		guard let index else {
			return
		}
		withAnimation(appSettings.display.willReduceMotion ? nil : .default) {
			proxy.scrollTo(browserModel.filteredApps[index].id, anchor: nil)
		}
	}
}
