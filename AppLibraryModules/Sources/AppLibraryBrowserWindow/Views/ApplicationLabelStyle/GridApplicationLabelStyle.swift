import AppLibraryRuntimeModelViews
import SwiftUI

struct GridApplicationLabelStyle: ApplicationLabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .center, spacing: 4) {
			configuration.icon
				.frame(height: 48)

			configuration.title
				.font(.footnote)
				.lineLimit(2, reservesSpace: true)
		}
		.multilineTextAlignment(.center)
		.contentShape(.rect)
	}
}

// MARK: - Convenience

extension ApplicationLabelStyle where
	Self == GridApplicationLabelStyle
{
	static var grid: Self {
		Self()
	}
}
