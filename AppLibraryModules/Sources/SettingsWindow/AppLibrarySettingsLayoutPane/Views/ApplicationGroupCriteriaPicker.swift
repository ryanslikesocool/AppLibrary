import AppLibraryCommon
import AppLibraryResources
import AppLibraryStorage
import SwiftUI

struct ApplicationGroupCriteriaPicker: View {
	fileprivate typealias SelectionValue = ApplicationGroupCriteria?

	@Storage(layout: \.groupCriteria) private var selection

	public init() { }

	public var body: some View {
		Picker(
			selection: $selection,
			content: Self.makePickerContent,
		) {
			Text(.applicationGroupCriteriaPicker.title)
		}
	}
}

// MARK: - Constants

private extension ApplicationGroupCriteriaPicker {
	nonisolated static let itemDisplayOrder: [[SelectionValue]] = [
		[
			.none,
		],
		[
			.category,
		],
	]
}

// MARK: - Supporting Views

private extension ApplicationGroupCriteriaPicker {
	nonisolated static func makePickerContent() -> some View {
		ForEach(itemDisplayOrder.indices, id: \.self) { groupIndex in
			Section {
				ForEach(
					Self.itemDisplayOrder[groupIndex], id: \.self,
					content: makeItem(_:)
				)
			}
		}
	}

	nonisolated static func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.labelKey)
			.tag(item)
	}
}

// MARK: -

private extension ApplicationGroupCriteriaPicker.SelectionValue {
	var labelKey: LocalizedStringResource {
		switch self {
			case .category?: .applicationGroupCriteriaPicker.item.category.title
			case .none: .applicationGroupCriteriaPicker.item.none.title
		}
	}
}
