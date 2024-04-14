import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct AppIterator: View {
		@Environment(\.libraryLayout) private var libraryLayout
		@ObservedObject private var browserModel: BrowserModel = .shared

		private var apps: [Application] { browserModel.filteredApps }

		@FocusState private var focusedIndex: Int?

		var body: some View {
			ForEach(apps.indices, id: \.self) { index in
				AppTile(application: apps[index])
					.focused($focusedIndex, equals: index)
			}

			.onChange(of: browserModel.focusedIndex) { _, newValue in
				if newValue != nil {
					browserModel.isSearchFocused = false
				}
				focusedIndex = newValue
			}
		}
	}
}
