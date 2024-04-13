import AppLibraryStorage
import SwiftUI

extension AppBrowser {
	struct GridView: View {
		let apps: [Application]

		var body: some View {
			LazyVGrid(columns: Self.gridColumns) {
				ForEach(apps) { app in
					AppTile(application: app)
				}
			}
			.padding(.horizontal, Self.gridPadding)
			.libraryLayout(.grid)
		}
	}
}

// MARK: - Constants

private extension AppBrowser.GridView {
	static let gridPadding: Double = 8
	static let gridColumns: [GridItem] = [GridItem](repeating: GridItem(), count: 4)
}
