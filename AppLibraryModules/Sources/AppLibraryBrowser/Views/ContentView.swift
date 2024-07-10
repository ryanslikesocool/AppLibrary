import AppLibraryCommonViews
import AppLibrarySettingsViews
import AppLibraryStorage
import SettingsAccess
import SwiftUI

struct ContentView: View {
	@Setting(layout: \.layout) private var layout
	@ObservedObject private var browserModel: BrowserModel

	init(browserModel: BrowserModel) {
		self.browserModel = browserModel
	}

	var body: some View {
		Group {
			switch browserModel.state {
				case .some(.loading): queryLoadingView
				case .some(.complete): LibraryView()
				case let .some(.failed(reason)): ErrorView(reason: reason)
				case .none: EmptyView()
			}
		}

		.background(.separator, in: containerShape.stroke(lineWidth: 1))
		.overlay(alignment: .top) {
			if browserModel.isSearchDisplayed {
				SearchField()
			}
		}
		.ignoresSafeArea()

		.libraryLayout(layout)
		.openSettingsAccess()

		.onChange(of: browserModel.filteredApps) { _, newValue in
			if browserModel.searchQuery.isEmpty {
				browserModel.state = if newValue.isEmpty {
					.failed(reason: .allHidden)
				} else {
					.complete
				}
			}
		}

		.environmentObject(browserModel)
	}
}

// MARK: - Supporting Views

extension ContentView {
	var containerShape: RoundedRectangle {
		.rect(cornerRadius: BrowserWindow.cornerRadius)
	}

	var queryLoadingView: some View {
		ProgressView()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
