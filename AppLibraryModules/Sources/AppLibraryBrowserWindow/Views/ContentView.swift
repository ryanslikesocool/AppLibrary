import AppLibraryCommon
import OSLog
import AppLibraryCommonViews
import AppLibraryStorage
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
		.onReceive(Event.refreshApps) {
			FeatureFlag.Input.logEvent(in: Self.self, named: "refreshApps")
			browserModel.refreshApps()
		}

//		.onChange(of: browserModel.filteredApps) { _, newValue in
//			browserModel.filteredAppsChanged(newValue)
//		}

		.environmentObject(browserModel)

		.defaultFocus($focusState, nil)
//		.onChange(of: browserModel.focus) { _, newValue in
//			focusState = newValue
//		}
	}
}

// MARK: - Supporting Views

extension ContentView {
	var queryLoadingView: some View {
		ProgressView()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
