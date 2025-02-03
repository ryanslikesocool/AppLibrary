import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftData
import SwiftUI

extension LibraryView {
	struct GridView: View {
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
			LazyVGrid(columns: Self.gridColumns) {
				ApplicationIterator(
					applications: applications,
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