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
			LazyVStack(pinnedViews: .sectionHeaders) {
				ApplicationIterator(
					applications: browserModel.filteredApps,
					focusState: $focusState
				)
				.grouped()
			}
		}
	}
}
