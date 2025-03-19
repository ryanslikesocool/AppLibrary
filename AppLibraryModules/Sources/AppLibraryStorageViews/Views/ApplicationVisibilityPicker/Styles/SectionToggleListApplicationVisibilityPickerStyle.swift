import SwiftUI

public struct SectionToggleListApplicationVisibilityPickerStyle: ApplicationVisibilityPickerStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Section {
			ForEach(configuration.items) { element in
				Toggle(
					element.localizedStringResource,
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
	nonisolated static var sectionToggleList: Self {
		Self()
	}
}
