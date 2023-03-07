import LoveCore
import MoreViews
import SwiftUI

struct AppListView: View {
	@EnvironmentObject private var appDelegate: AppDelegate
	@Environment(\.libraryStyle) private var libraryStyle: LibraryStyle
	@State private var searchQuery: String = ""

	var body: some View {
		ScrollViewReader { scrollReader in
			ScrollView(.vertical) {
				scrollContent
			}
			.onReceive(Notification.Name.scrollJump.publisher()) { notification in
				guard let key = notification.userInfo?["character"] as? String else {
					return
				}
				// withAnimation {
				scrollReader.scrollTo(key.first!, anchor: .top)
				// }
			}
		}
		.frame(width: viewWidth)
		.frame(minHeight: viewWidth + settings.iconSize)
	}
}

// MARK: - Data

private extension AppListView {
	var settings: AppSettings { appDelegate.settings }

	var viewWidth: Double {
		let count = Double(settings.columns)
		return (count * settings.iconSize) + (settings.padding * 2 + settings.spacing) + ((count - 1.0) * settings.spacing)
	}

	var applicationURLs: [URL] {
		let initialResult = appDelegate.state.applicationURLs
			.filter { $0.pathExtension == "app" }
			.filter { !appDelegate.settings.hiddenApps.contains($0.lastPathComponent) }
			.sorted(by: { $0.lastPathComponent < $1.lastPathComponent })

		guard !searchQuery.isEmpty else {
			return initialResult
		}

		let search = searchQuery.lowercased()
		return initialResult.filter { $0.lastPathComponent.lowercased().contains(search) }
	}
}

// MARK: - Views

private extension AppListView {
	@ViewBuilder var scrollContent: some View {
		switch libraryStyle {
			case .tile: gridView
			case .list: listView
		}
	}

	var iterateURLs: some View {
		ForEach(applicationURLs, id: \.self) { url in
			AppTile(url)
				.id(url.lastPathComponent.first!)
		}
	}
}

// MARK: - Grid

private extension AppListView {
	private var gridColumns: [GridItem] {
		let preset = GridItem(.flexible(), spacing: settings.spacing, alignment: .center)
		return [GridItem](repeating: preset, count: settings.columns)
	}

	var gridView: some View {
		LazyVGrid(columns: gridColumns, alignment: .leading) {
			iterateURLs
				.padding(.vertical, settings.spacing * 0.25)
		}
		.padding(horizontal: settings.spacing * 0.5, vertical: settings.spacing * 0.25)
		.padding(settings.padding)
	}
}

// MARK: - List

private extension AppListView {
	var listView: some View {
		LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
			Section {
				iterateURLs
			} header: {
				SearchBar(query: $searchQuery)
			}
		}
		.padding(.bottom, 8)
	}
}
