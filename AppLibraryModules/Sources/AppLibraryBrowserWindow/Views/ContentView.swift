import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct ContentView: View {
	@Storage(layout: \.layout) private var layout
	@ObservedObject private var browserModel: BrowserModel

	public init(browserModel: BrowserModel) {
		self.browserModel = browserModel
	}

	public var body: some View {
		Group {
			switch browserModel.state {
				case .idle: LibraryView()
				case .loading: queryLoadingView
				case let .error(error): ErrorView(reason: error)
			}
		}

		.overlay(alignment: .top) {
			if browserModel.isSearchDisplayed {
				SearchField()
			}
		}
		.ignoresSafeArea()

		.libraryLayout(layout)

//		.onChange(of: browserModel.filteredApps) { _, newValue in
//			browserModel.filteredAppsChanged(newValue)
//		}

		.environmentObject(browserModel)
	}
}

// MARK: - Supporting Views

extension ContentView {
	var queryLoadingView: some View {
		ProgressView()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
