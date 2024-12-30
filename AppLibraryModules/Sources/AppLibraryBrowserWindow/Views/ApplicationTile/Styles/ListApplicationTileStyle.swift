import SwiftUI

struct ListApplicationTileStyle: ApplicationTileStyle {
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

extension ApplicationTileStyle where
	Self == ListApplicationTileStyle
{
	static var list: Self {
		Self()
	}
}
