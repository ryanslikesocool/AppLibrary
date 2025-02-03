import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftData
import SwiftUI

extension LibraryView {
	struct ListView: View {
		@Query private var applications: [ApplicationModel]
		@FocusState.Binding private var focusState: BrowserFocusElement?

		public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
//			let predicate = #Predicate<ApplicationModel> { applicationModel in
//				// TODO: Reimplement visibility flags
//			}
			let sortDescriptors: [SortDescriptor<ApplicationModel>] = [
				SortDescriptor(\.displayName),
			]

			_applications = Query(
				filter: nil,
				sort: sortDescriptors
			)

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
			applications: applications,
			focusState: $focusState
		)
		.grouped()
	}
}
