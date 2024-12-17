import AppLibraryCommon
internal import AppLibraryLocalization
import AppLibraryStorage
import SwiftUI

struct LibraryLayoutPicker: View {
	fileprivate typealias SelectionValue = LibraryLayout

	@Storage(layout: \.layout) private var selection: SelectionValue

	public init() { }

	public var body: some View {
		Picker(selection: $selection) {
			ForEach(Self.itemDisplayOrder, content: makeItem)
		} label: {
			Text(.libraryLayoutPicker.label)
		}
	}
}

// MARK: - Supporting Views

private extension LibraryLayoutPicker {
	func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.labelKey)
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
	var labelKey: LocalizedStringResource {
		switch self {
			case .list: .libraryLayoutPicker.item.list
			case .grid: .libraryLayoutPicker.item.grid
		}
	}
}
