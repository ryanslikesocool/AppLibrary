import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct ListView: View {
		var body: some View {
			LazyVStack {
				AppIterator()
			}
		}
	}
}
