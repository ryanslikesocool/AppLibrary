import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var applicationVisibilityPickerStyle: AnyApplicationVisibilityPickerStyle
		= AnyApplicationVisibilityPickerStyle(.sectionToggleList)
}

// MARK: - Convenience

public extension View {
	nonisolated func applicationVisibilityPickerStyle<Style>(_ style: Style) -> some View where
		Style: ApplicationVisibilityPickerStyle
	{
		environment(\.applicationVisibilityPickerStyle, AnyApplicationVisibilityPickerStyle(style))
	}
}
