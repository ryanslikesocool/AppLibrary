import AppLibraryStorage
import OSLog
import SwiftUI

struct AppBrowser: View {
	@ObservedObject private var browserModel: BrowserModel = .shared
	@ObservedObject private var appSettings: AppSettings = .shared

	var body: some View {
		switch browserModel.queryState {
			case .some(.loading): queryLoadingView
			case .some(.complete): BrowserView()
			case let .some(.failed(reason)): QueryFailedView(reason: reason)
			case .none: EmptyView()
		}
	}
}

// MARK: - Supporting Views

private extension AppBrowser {
	var queryLoadingView: some View {
		ProgressView()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
