import AppLibraryStorage
import AppLibraryRuntimeModel
import SwiftData
import SwiftUI

extension LibraryView {
	struct GridView: View {
		@Query private var applications: [ApplicationModel]

		@FocusState.Binding private var focusState: BrowserFocusElement?

		public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
//			let predicate = #Predicate<ApplicationModel> { applicationModel in
//				// TODO: Reimplement visibility flags
//			}
			let sortDescriptors: [SortDescriptor<ApplicationModel>] = [
				SortDescriptor(\.displayName)
			]

			_applications = Query(
				filter: nil,
				sort: sortDescriptors
			)

			_focusState = focusState
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
