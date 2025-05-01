import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var errorViewStyle: AnyErrorViewStyle = AnyErrorViewStyle(.default)
}

// MARK: - Convenience

public extension View {
	nonisolated func errorViewStyle<Style>(
		_ style: Style,
	) -> some View where
		Style: ErrorViewStyle
	{
		environment(\.errorViewStyle, AnyErrorViewStyle(style))
	}
}