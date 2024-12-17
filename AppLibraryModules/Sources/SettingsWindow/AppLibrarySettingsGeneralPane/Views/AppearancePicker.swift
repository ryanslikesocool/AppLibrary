import AppLibraryCommon
internal import AppLibraryLocalization
import AppLibraryStorage
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
			Text(.appearancePicker.label)
		}
		.onChange(of: selection, selection.apply)
	}
}

// MARK: - Supporting Views

private extension AppearancePicker {
	func makeItem(
		_ item: SelectionValue
	) -> some View {
		Text(item.labelKey)
			.tag(item)
	}
}

// MARK: -

private extension AppearancePicker.SelectionValue {
	var labelKey: LocalizedStringResource {
		switch self {
			case .system: .appearancePicker.item.system
			case .light: .appearancePicker.item.light
			case .dark: .appearancePicker.item.dark
		}
	}
}
