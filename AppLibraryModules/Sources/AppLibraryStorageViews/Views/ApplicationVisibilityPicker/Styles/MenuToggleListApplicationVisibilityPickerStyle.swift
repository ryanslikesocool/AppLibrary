import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

public struct MenuToggleListApplicationVisibilityPickerStyle: ApplicationVisibilityPickerStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Menu {
			ForEach(configuration.elements) { element in
				Toggle(
					LocalizedStringResource.applicationVisibilityPicker.item.format.adjective(element.localizedStringResource),
					selection: configuration.$selection,
					element: element
				)
			}
		} label: {
			configuration.label
		}
	}
}

// MARK: - Convenience

public extension ApplicationVisibilityPickerStyle where
	Self == MenuToggleListApplicationVisibilityPickerStyle
{
	static var menuToggleList: Self {
		Self()
	}
}
