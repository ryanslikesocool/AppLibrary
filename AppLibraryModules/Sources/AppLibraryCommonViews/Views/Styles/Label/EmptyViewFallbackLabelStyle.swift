import SwiftUI

/// ## Topics
/// - ``LabelStyle/emptyViewFallback``
public struct EmptyViewFallbackLabelStyle: LabelStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack {
			configuration.icon
				.font(Self.iconFont)

			configuration.title
				.font(Self.titleFont)
		}
		.foregroundStyle(Self.foregroundStyle)
	}
}

// MARK: - Constants

private extension EmptyViewFallbackLabelStyle {
	static var iconFont: Font { Font.title }
	static var titleFont: Font { Font.title2 }
	static var foregroundStyle: some ShapeStyle { .tertiary }
}

// MARK: - Convenience

public extension LabelStyle where
	Self == EmptyViewFallbackLabelStyle
{
	nonisolated static var emptyViewFallback: Self {
		Self()
	}
}
