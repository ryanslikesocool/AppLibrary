import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct ApplicationIterator: View {
		@EnvironmentObject private var browserModel: BrowserModel
		@Environment(\.libraryLayout) private var libraryLayout

		@FocusState.Binding private var focusState: BrowserFocusElement?

		private var applications: [ApplicationModel] {
			browserModel.filteredApps
		}

		public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
			_focusState = focusState
		}

		public var body: some View {
			ForEach(applications, id: \.bundleIdentifier) { application in
				ApplicationTile(for: application)
					.focused($focusState, equals: .application(application))
			}
			.focusSection()
		}
	}
}
