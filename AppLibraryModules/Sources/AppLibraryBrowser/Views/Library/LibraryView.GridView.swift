import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct GridView: View {
		var body: some View {
			LazyVGrid(columns: Self.gridColumns) {
				AppIterator()
			}
		}
	}
}

// MARK: - Constants

private extension LibraryView.GridView {
	static let gridColumns: [GridItem] = [GridItem](repeating: GridItem(), count: 4)
}
