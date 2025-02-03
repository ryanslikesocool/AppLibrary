import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftData
import SwiftUI

extension LibraryView {
	struct ListView: View {
		@FocusState.Binding private var focusState: BrowserFocusElement?
		private let applications: [ApplicationModel]

		public init(
			applications: [ApplicationModel],
			focusState: FocusState<BrowserFocusElement?>.Binding
		) {
			_focusState = focusState
			self.applications = applications
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
			applications: applications,
			focusState: $focusState
		)
		.grouped()
	}
}
