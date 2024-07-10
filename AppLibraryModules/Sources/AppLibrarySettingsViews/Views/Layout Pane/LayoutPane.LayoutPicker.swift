import AppLibraryStorage
import SwiftUI

extension LayoutPane {
	struct LayoutPicker: View {
		@Binding var selection: LibraryLayout

		var body: some View {
			Picker("Layout", selection: $selection) {
				Text("List").tag(LibraryLayout.list)
				Text("Grid").tag(LibraryLayout.grid)
			}
		}
	}
}
