import SwiftUI

struct GridApplicationTileStyle: ApplicationTileStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .center, spacing: 4) {
			configuration.icon
				.frame(height: 48)

			configuration.label
				.font(.footnote)
				.lineLimit(2, reservesSpace: true)
		}
		.multilineTextAlignment(.center)
		.contentShape(.rect)
	}
}

// MARK: - Convenience

extension ApplicationTileStyle where
	Self == GridApplicationTileStyle
{
	static var grid: Self {
		Self()
	}
}
