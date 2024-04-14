import AppLibraryStorage
import SwiftUI

extension BrowserView {
	struct GridView: View {
		let apps: [Application]

		var body: some View {
			LazyVGrid(columns: Self.gridColumns) {
				ForEach(apps) { app in
					AppTile(application: app)
				}
			}
			.padding(.horizontal, LibraryLayout.grid.padding)
			.libraryLayout(.grid)
		}
	}
}

// MARK: - Constants

private extension BrowserView.GridView {
	static let gridColumns: [GridItem] = [GridItem](repeating: GridItem(), count: 4)
}
