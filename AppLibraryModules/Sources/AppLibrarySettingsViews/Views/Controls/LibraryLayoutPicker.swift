import AppLibraryStorage
import SwiftUI

struct LibraryLayoutPicker: View {
	public typealias SelectionValue = LibraryLayout

	@Storage(layout: \.layout) private var selection: SelectionValue

	public init() { }

	public var body: some View {
		Picker("Layout", selection: $selection) {
			makeItem(.list) {
				Text("List")
			}
			makeItem(.grid) {
				Text("Grid")
			}
		}
	}
}

// MARK: - Supporting Views

private extension LibraryLayoutPicker {
	func makeItem(
		_ tag: SelectionValue,
		@ViewBuilder label: () -> some View
	) -> some View {
		label()
			.tag(tag)
	}
}