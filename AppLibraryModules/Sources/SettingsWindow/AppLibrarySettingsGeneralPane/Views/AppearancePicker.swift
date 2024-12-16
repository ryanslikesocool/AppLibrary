import AppLibraryCommon
import AppLibraryStorage
import LocalizationTable
import SwiftUI

struct AppearancePicker: View {
	fileprivate typealias SelectionValue = Appearance

	@Storage(general: \.appearance) private var selection: SelectionValue

	public init() { }

	public var body: some View {
		Picker(selection: $selection) {
			makeItem(.system)

			Section {
				makeItem(.light)
				makeItem(.dark)
			}
		} label: {
			Text(.appearancePicker.label, table: .appearancePicker)
		}
		.onChange(of: selection, selection.apply)
	}
}

// MARK: - Supporting Views

private extension AppearancePicker {
	func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.labelKey, table: .appearancePicker)
			.tag(item)
	}
}

// MARK: -

private extension AppearancePicker.SelectionValue {
	var labelKey: LocalizedStringKey {
		switch self {
			case .system: .appearancePicker.item.system
			case .light: .appearancePicker.item.light
			case .dark: .appearancePicker.item.dark
		}
	}
}

private extension LocalizationTableResource {
	static var appearancePicker: Self {
		LocalizationKey<String.LocalizationValue>.AppearancePicker.localizationTable
	}
}
