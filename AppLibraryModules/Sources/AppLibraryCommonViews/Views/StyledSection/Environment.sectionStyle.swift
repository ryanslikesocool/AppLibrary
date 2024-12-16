import SwiftUI

public extension EnvironmentValues {
	@Entry
	fileprivate(set) var sectionStyle: AnySectionStyle = AnySectionStyle(.automatic)
}

// MARK: - Convenience

public extension View {
	nonisolated func sectionStyle<S>(_ style: S) -> some View where
		S: SectionStyle
	{
		environment(\.sectionStyle, AnySectionStyle(style))
	}
}