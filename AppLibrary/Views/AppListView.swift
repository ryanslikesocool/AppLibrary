import ALSettings
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

				// TODO: fix scroll jump
				withAnimation {
					scrollReader.scrollTo(key.first!, anchor: .top)
				}
			}
		}
//		.frame(width: viewWidth)
//		.frame(minHeight: viewWidth + settings.iconSize)
	}
}

// MARK: - Data

private extension AppListView {
	var settings: AppSettings { appDelegate.settings }

//	var viewWidth: Double {
//		let count = Double(settings.columns)
//		return (count * settings.iconSize) + (settings.padding * 2 + settings.spacing) + ((count - 1.0) * settings.spacing)
//	}

	var filteredApplications: [AppIdentifier] {
		let initialResult = settings.appDirectories.applications
			.filter { $0.pathExtension == "app" && !$0.isHidden }
			.sorted(by: { $0.description < $1.description })

		guard !searchQuery.isEmpty else {
			return initialResult
		}

		let search = searchQuery.lowercased()
		return initialResult.filter { $0.description.lowercased().contains(search) }
	}
}

// MARK: - Views

private extension AppListView {
	@ViewBuilder var scrollContent: some View {
//		switch libraryStyle {
//			case .tile: gridView
//			case .list: listView
//		}

		listView
	}

	var iterateURLs: some View {
		let applicationsBinding = Binding(
			get: { filteredApplications },
			set: { newValue in
				for item in newValue {
					guard
						let directoryIndex = settings.appDirectories.appDirectories.firstIndex(where: { $0.apps.contains(where: { $0.id == item.id }) }),
						let appIndex = settings.appDirectories.appDirectories[directoryIndex].apps.firstIndex(where: { $0.id == item.id })
					else {
						continue
					}
					settings.appDirectories.appDirectories[directoryIndex].apps[appIndex] = item
				}
			}
		)

		return ForEach(applicationsBinding) { $application in
			AppTile($application)
				.id(application.description.first!)
		}
	}
}

// MARK: - Grid

// private extension AppListView {
//	private var gridColumns: [GridItem] {
//		let preset = GridItem(.flexible(), spacing: settings.spacing, alignment: .center)
//		return [GridItem](repeating: preset, count: settings.columns)
//	}
//
//	var gridView: some View {
//		LazyVGrid(columns: gridColumns, alignment: .leading) {
//			iterateURLs
//				.padding(.vertical, settings.spacing * 0.25)
//		}
//		.padding(horizontal: settings.spacing * 0.5, vertical: settings.spacing * 0.25)
//		.padding(settings.padding)
//	}
// }

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
