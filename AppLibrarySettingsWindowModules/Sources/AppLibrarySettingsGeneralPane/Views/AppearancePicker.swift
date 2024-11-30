import AppLibraryStorage
import LocalizationTable
import SwiftUI

struct AppearancePicker: View {
	fileprivate typealias SelectionValue = Appearance?

	@Storage(general: \.appearance) private var selection: SelectionValue

	public init() { }

	public var body: some View {
		Picker(selection: $selection) {
			makeItem(.none)

			Section {
				makeItem(.light)
				makeItem(.dark)
			}
		} label: {
			Text("LABEL", table: .appearancePicker)
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
			case .light?: "ITEM.LIGHT.LABEL"
			case .dark?: "ITEM.DARK.LABEL"
			case .none: "ITEM.SYSTEM.LABEL"
		}
	}
}

private extension LocalizationTableResource {
	static let appearancePicker: Self = "AppearancePicker"
}
