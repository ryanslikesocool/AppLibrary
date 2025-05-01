import AppLibraryRuntimeModelViews
import SwiftUI

struct GridApplicationLabelStyle: ApplicationLabelStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .center, spacing: Self.spacing) {
			configuration.icon
				.frame(height: Self.iconSize)

			configuration.title
				.font(Self.titleFont)
				.lineLimit(2, reservesSpace: true)
		}
		.multilineTextAlignment(.center)
		.contentShape(.rect)
	}
}

// MARK: - Constants

private extension GridApplicationLabelStyle {
	static let spacing: CGFloat? = 4

	static let iconSize: CGFloat? = 48

	static var titleFont: Font { .footnote }
}

// MARK: - Convenience

extension ApplicationLabelStyle where
	Self == GridApplicationLabelStyle
{
	nonisolated static var grid: Self {
		Self()
	}
}
