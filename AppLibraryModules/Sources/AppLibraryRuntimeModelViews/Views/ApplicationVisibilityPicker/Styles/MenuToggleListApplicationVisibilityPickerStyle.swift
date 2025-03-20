import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

public struct MenuToggleListApplicationVisibilityPickerStyle: ApplicationVisibilityPickerStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Menu {
			ForEach(configuration.items) { element in
				Toggle(
					element.localizedStringResource,
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
	nonisolated static var menuToggleList: Self {
		Self()
	}
}
