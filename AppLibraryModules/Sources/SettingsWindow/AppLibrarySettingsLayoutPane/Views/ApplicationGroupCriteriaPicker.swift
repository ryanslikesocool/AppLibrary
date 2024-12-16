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
			Text(.applicationGroupCriteriaPicker.label, table: .applicationGroupCriteriaPicker)
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationGroupCriteriaPicker {
	func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.labelKey, table: .applicationGroupCriteriaPicker)
			.tag(item)
	}
}

// MARK: -

private extension ApplicationGroupCriteriaPicker.SelectionValue {
	var labelKey: LocalizedStringKey {
		switch self {
			case .category?: .applicationGroupCriteriaPicker.item.category
			case .none: .applicationGroupCriteriaPicker.item.none
		}
	}
}

private extension LocalizationTableResource {
	static var applicationGroupCriteriaPicker: Self {
		LocalizationKey<String.LocalizationValue>.ApplicationGroupCriteriaPicker.localizationTable
	}
}
