import SwiftUI

public struct DefaultErrorViewStyle: ErrorViewStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack {
			configuration.icon
				.fontWeight(Self.iconFontWeight)
				.frame(width: Self.iconWidth, height: Self.iconHeight)
				.padding(.horizontal, Self.iconHorizontalPadding)

			configuration.title
				.font(Self.titleFont)

			configuration.recoverySuggestion

			configuration.recoveryAction
		}
		.multilineTextAlignment(Self.multilineTextAlignment)
		.foregroundStyle(Self.foregroundStyle)
		.frame(maxWidth: Self.maxWidth, maxHeight: Self.maxHeight)
		.padding()
	}
}

// MARK: - Constants

private extension DefaultErrorViewStyle {
	static var iconFontWeight: Font.Weight { .semibold }

	static let iconWidth: CGFloat? = 48
	static var iconHeight: CGFloat? { iconWidth }

	static let iconHorizontalPadding: CGFloat = 32

	static var titleFont: Font { .title.weight(.semibold) }

	static let multilineTextAlignment: TextAlignment = .center
	static var foregroundStyle: some ShapeStyle { .secondary }

	static var maxWidth: CGFloat? { .infinity }
	static var maxHeight: CGFloat? { .infinity }
}

// MARK: - Convenience

public extension ErrorViewStyle where
	Self == DefaultErrorViewStyle
{
	nonisolated static var `default`: Self {
		Self()
	}
}
