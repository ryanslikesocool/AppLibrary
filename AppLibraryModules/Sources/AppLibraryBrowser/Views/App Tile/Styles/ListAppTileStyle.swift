import SwiftUI

struct ListAppTileStyle: AppTileStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.icon
				.frame(height: 56)

			configuration.label
				.font(.body)

			Spacer()
		}
		.contentShape(.rect)
	}
}

extension AppTileStyle where Self == ListAppTileStyle {
	static var list: Self { Self() }
}
