import SwiftUI

struct ListAppTileStyle: AppTileStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
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

// MARK: - Convenience

extension AppTileStyle where
	Self == ListAppTileStyle
{
	static var list: Self {
		Self()
	}
}
