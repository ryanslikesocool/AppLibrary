import AppLibraryRuntimeModelViews
import SwiftUI

struct ListApplicationLabelStyle: ApplicationLabelStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		HStack(spacing: Self.spacing) {
			configuration.icon
				.frame(height: Self.iconSize)

			configuration.title
				.font(Self.titleFont)

			Spacer()
		}
		.contentShape(.rect)
	}
}

// MARK: - Constants

private extension ListApplicationLabelStyle {
	static let spacing: CGFloat? = nil

	static let iconSize: CGFloat? = 56

	static var titleFont: Font { .body }
}

// MARK: - Convenience

extension ApplicationLabelStyle where
	Self == ListApplicationLabelStyle
{
	nonisolated static var list: Self {
		Self()
	}
}
