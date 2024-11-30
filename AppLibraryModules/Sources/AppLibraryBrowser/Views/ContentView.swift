import AppLibraryCommonViews
import AppLibrarySettingsViews
import AppLibraryStorage
import SettingsAccess
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
				case .loading?: queryLoadingView
				case .complete?: LibraryView()
				case let .some(.failed(reason)): ErrorView(reason: reason)
				case nil: EmptyView()
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
			browserModel.filteredAppsChanged(newValue)
		}

		.environmentObject(browserModel)
	}
}

// MARK: - Supporting Views

extension ContentView {
	var containerShape: some InsettableShape {
		BrowserWindowShape()
	}

	var queryLoadingView: some View {
		ProgressView()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
