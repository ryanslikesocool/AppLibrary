import AppLibraryCommon
import AppLibraryResources
import AppLibraryStorage
import SwiftUI

struct LibraryLayoutPicker: View {
	fileprivate typealias SelectionValue = LibraryLayout

	@Storage(layout: \.layout) private var selection: SelectionValue

	public init() { }

	public var body: some View {
		Picker(
			String(localized: .libraryLayoutPicker.title),
			selection: $selection
		) {
			ForEach(Self.itemDisplayOrder, content: makeItem)
		}
	}
}

// MARK: - Supporting Views

private extension LibraryLayoutPicker {
	func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.localizedStringResource)
			.tag(item)
	}
}

// MARK: - Constants

private extension LibraryLayoutPicker {
	static let itemDisplayOrder: [SelectionValue] = [
		.list,
		.grid,
	]
}
