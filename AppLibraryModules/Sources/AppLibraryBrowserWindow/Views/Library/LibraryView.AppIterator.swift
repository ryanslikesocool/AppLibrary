import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct AppIterator: View {
		@EnvironmentObject private var browserModel: BrowserModel
		@Environment(\.libraryLayout) private var libraryLayout

		@FocusState private var focusedApp: FocusElement?

		private var applications: [ApplicationModel] {
			browserModel.filteredApps
		}

		public init() { }

		public var body: some View {
			ForEach(applications, id: \.bundleIdentifier) { application in
				AppTile(for: application)
					.focused($focusedApp, equals: .app(ApplicationModelIdentifier(application)))
			}
			.onChange(of: browserModel.focus) {
				focusedApp = browserModel.focus
			}
		}
	}
}
