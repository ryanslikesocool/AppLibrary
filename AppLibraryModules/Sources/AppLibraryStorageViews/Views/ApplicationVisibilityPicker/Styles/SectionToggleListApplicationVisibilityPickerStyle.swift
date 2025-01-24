import SwiftUI

public struct SectionToggleListApplicationVisibilityPickerStyle: ApplicationVisibilityPickerStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Section {
			ForEach(configuration.elements) { element in
				Toggle(
					LocalizedStringResource.applicationVisibilityPicker.item.format.adjective(element.localizedStringResource),
					selection: configuration.$selection,
					element: element
				)
			}
		} header: {
			configuration.label
		}
	}
}

// MARK: - Convenience

public extension ApplicationVisibilityPickerStyle where
	Self == SectionToggleListApplicationVisibilityPickerStyle
{
	static var sectionToggleList: Self {
		Self()
	}
}