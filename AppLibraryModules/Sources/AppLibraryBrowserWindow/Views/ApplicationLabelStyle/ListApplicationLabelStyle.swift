import AppLibraryRuntimeModelViews
import SwiftUI

struct ListApplicationLabelStyle: ApplicationLabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.icon
				.frame(height: 56)

			configuration.title
				.font(.body)

			Spacer()
		}
		.contentShape(.rect)
	}
}

// MARK: - Convenience

extension ApplicationLabelStyle where
	Self == ListApplicationLabelStyle
{
	static var list: Self {
		Self()
	}
}
