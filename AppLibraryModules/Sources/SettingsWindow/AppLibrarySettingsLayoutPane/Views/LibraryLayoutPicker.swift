import AppLibraryStorage
import LocalizationTable
import SwiftUI

struct LibraryLayoutPicker: View {
	fileprivate typealias SelectionValue = LibraryLayout

	@Storage(layout: \.layout) private var selection: SelectionValue

	public init() { }

	public var body: some View {
		Picker(selection: $selection) {
			ForEach(Self.itemDisplayOrder, content: makeItem)
		} label: {
			Text("LABEL", table: .libraryLayoutPicker)
		}
	}
}

// MARK: - Supporting Views

private extension LibraryLayoutPicker {
	func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.labelKey, table: .libraryLayoutPicker)
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

// MARK: -

private extension LibraryLayoutPicker.SelectionValue {
	var labelKey: LocalizedStringKey {
		switch self {
			case .list: "ITEM.LIST.LABEL"
			case .grid: "ITEM.GRID.LABEL"
		}
	}
}

private extension LocalizationTableResource {
	static let libraryLayoutPicker: Self = "LibraryLayoutPicker"
}
