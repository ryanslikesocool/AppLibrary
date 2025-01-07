import AppLibraryRuntimeModel
import AppLibraryStorage
import EnvironmentalFocus
import SwiftUI

extension LibraryView {
	struct AppIterator: View {
		@EnvironmentObject private var browserModel: BrowserModel
		@Environment(\.libraryLayout) private var libraryLayout

		@EnvironmentFocus(\.browserFocus) private var focusState

		private var applications: [ApplicationModel] {
			browserModel.filteredApps
		}

		public init() {	}

		public var body: some View {
			ForEach(applications, id: \.bundleIdentifier) { application in
				ApplicationTile(for: application)
					.focused($focusState, equals: .app(ApplicationModelIdentifier(application)))
			}
			.onChange(of: browserModel.focus) {
				focusState = browserModel.focus
			}
//			.focusSection()
		}
	}
}
