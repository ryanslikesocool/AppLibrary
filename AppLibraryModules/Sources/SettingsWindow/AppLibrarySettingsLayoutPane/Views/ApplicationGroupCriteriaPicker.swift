import AppLibraryCommon
import AppLibraryStorage
import LocalizationTable
import SwiftUI

struct ApplicationGroupCriteriaPicker: View {
	fileprivate typealias SelectionValue = ApplicationGroupCriteria?

	@Storage(layout: \.groupCriteria) private var selection

	public init() { }

	public var body: some View {
		Picker(selection: $selection) {
			makeItem(.none)

			Section {
				makeItem(.category)
			}
		} label: {
			Text(.applicationGroupCriteriaPicker.label)
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationGroupCriteriaPicker {
	func makeItem(
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
			case .category?: .applicationGroupCriteriaPicker.item.category
			case .none: .applicationGroupCriteriaPicker.item.none
		}
	}
}