import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct ListView: View {
		public init() { }

		public var body: some View {
			LazyVStack {
				AppIterator()
			}
		}
	}
}
