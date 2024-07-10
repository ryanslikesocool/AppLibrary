import SwiftUI

struct GridAppTileStyle: AppTileStyle {
	func makeBody(configuration: Configuration) -> some View {
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

extension AppTileStyle where Self == GridAppTileStyle {
	static var grid: Self { Self() }
}
