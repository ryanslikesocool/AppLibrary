import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ContentView: View {
	@Storage(layout: \.layout) private var layout
	@ObservedObject private var browserModel: BrowserModel
	@FocusState private var focusState: BrowserFocusElement?

	public init(browserModel: BrowserModel) {
		self.browserModel = browserModel
	}

	public var body: some View {
		Group {
			switch browserModel.state {
				case .idle: LibraryView(focusState: $focusState)
				case .loading: queryLoadingView
				case let .error(error): ErrorView(reason: error)
			}
		}

		.ignoresSafeArea()
		.libraryLayout(layout)

//		.refreshable(action: browserModel.refreshApps)

		.inputReceiver(focusState: $focusState)

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
