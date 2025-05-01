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
			SelectionValue.typeDisplayRepresentation.name,
			selection: $selection
		) {
			ForEach(
				Self.itemDisplayOrder, id: \.self,
				content: Self.makeItem(_:)
			)
		}
	}
}

// MARK: - Constants

private extension LibraryLayoutPicker {
	static var itemDisplayOrder: [SelectionValue] {
		SelectionValue.allCases
	}
}

// MARK: - Supporting Views

private extension LibraryLayoutPicker {
	nonisolated static func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.localizedStringResource)
			.tag(item)
	}
}
