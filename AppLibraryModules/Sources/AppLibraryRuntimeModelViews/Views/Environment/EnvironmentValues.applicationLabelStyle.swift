import SwiftUI

public extension EnvironmentValues {
	@Entry
	fileprivate(set) var applicationLabelStyle: AnyApplicationLabelStyle = AnyApplicationLabelStyle(.default)
}

// MARK: - Convenience

public extension View {
	nonisolated func applicationLabelStyle<Style>(_ applicationLabelStyle: Style) -> some View where
		Style: ApplicationLabelStyle
	{
		environment(\.applicationLabelStyle, AnyApplicationLabelStyle(applicationLabelStyle))
	}
}
