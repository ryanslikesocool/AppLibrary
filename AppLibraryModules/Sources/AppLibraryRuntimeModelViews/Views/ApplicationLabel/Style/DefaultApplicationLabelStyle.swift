import SwiftUI

public struct DefaultApplicationLabelStyle: ApplicationLabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Label {
			configuration.title
				.lineLimit(1)
				.truncationMode(.tail)
		} icon: {
			configuration.icon
		}
	}
}

// MARK: - Convenience

public extension ApplicationLabelStyle where
	Self == DefaultApplicationLabelStyle
{
	static var `default`: Self {
		Self()
	}
}
