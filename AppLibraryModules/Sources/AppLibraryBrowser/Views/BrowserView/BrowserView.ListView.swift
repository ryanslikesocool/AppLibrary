import AppLibraryStorage
import SwiftUI

extension BrowserView {
	struct ListView: View {
		let apps: [Application]

		var body: some View {
			LazyVStack {
				ForEach(apps) { app in
					AppTile(application: app)
				}
			}
			.padding(.horizontal, LibraryLayout.list.padding)
			.libraryLayout(.list)
		}
	}
}
