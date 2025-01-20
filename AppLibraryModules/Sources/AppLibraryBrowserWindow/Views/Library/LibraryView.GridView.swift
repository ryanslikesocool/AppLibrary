import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct GridView: View {
		@EnvironmentObject private var browserModel: BrowserModel
		
		@FocusState.Binding private var focusState: BrowserFocusElement?

		public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
			_focusState = focusState
		}

		public var body: some View {
			LazyVGrid(columns: Self.gridColumns) {
				ApplicationIterator(
					applications: browserModel.filteredApps,
					focusState: $focusState
				)
			}
		}
	}
}

// MARK: - Constants

private extension LibraryView.GridView {
	static let gridColumns: [GridItem] = [GridItem](
		repeating: GridItem(),
		count: gridColumnCount
	)

	static let gridColumnCount: Int = 4
}
