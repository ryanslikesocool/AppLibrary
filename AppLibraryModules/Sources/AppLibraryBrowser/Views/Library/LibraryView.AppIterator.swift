import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct AppIterator: View {
		@EnvironmentObject private var browserModel: BrowserModel
		@Environment(\.libraryLayout) private var libraryLayout

		@FocusState private var focusedApp: FocusElement?

		private var apps: [Application] {
			browserModel.filteredApps
		}

		public init() { }

		public var body: some View {
			ForEach(apps) { app in
				AppTile(for: app)
					.focused($focusedApp, equals: .app(app.id))
			}
			.onChange(of: browserModel.focus) {
				focusedApp = browserModel.focus
			}
		}
	}
}
