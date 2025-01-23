import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct ListView: View {
		@EnvironmentObject private var browserModel: BrowserModel
		@FocusState.Binding private var focusState: BrowserFocusElement?

		public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
			_focusState = focusState
		}

		public var body: some View {
			switch FeatureFlag.ListView.implementation {
				case .list:
					content
				case .lazyVStack:
					LazyVStack(pinnedViews: .sectionHeaders) {
						content
					}
			}
		}
	}
}

// MARK: - Supporting Views

private extension LibraryView.ListView {
	var content: some View {
		ApplicationIterator(
			applications: browserModel.filteredApps,
			focusState: $focusState
		)
		.grouped()
	}
}
