import LoveCore
import MoreViews
import SwiftUI

struct AppListView: View {
	@EnvironmentObject private var appDelegate: AppDelegate
	@Environment(\.libraryStyle) private var libraryStyle: LibraryStyle
	@State private var searchQuery: String = ""

	var body: some View {
		ScrollView(.vertical) {
			scrollContent
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
		appDelegate.state.applicationURLs.sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
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
		}
	}

	var searchBar: some View {
		let container = RoundedRectangle(cornerRadius: 12, style: .continuous)

		return TextField(text: $searchQuery, label: {
			Label("Search", systemImage: "magnifyingglass")
		})
		.textFieldStyle(.roundedBorder)
		.controlSize(.large)
		.padding(4)
		.background(Material.regular, in: container)
		.compositingGroup()
		.shadow(radius: 4, y: 2)
		.padding(8)
		.allowUnfocus()
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
				searchBar
			}
		}
		.padding(.bottom, 8)
	}
}
