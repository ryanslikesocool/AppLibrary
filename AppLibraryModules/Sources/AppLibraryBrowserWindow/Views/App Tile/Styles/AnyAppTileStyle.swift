import SwiftUI

struct AnyAppTileStyle: AppTileStyle {
	private let _makeBody: @MainActor (Configuration) -> AnyView

	public init<S>(_ style: S) where
		S: AppTileStyle
	{
		_makeBody = if let style = style as? Self {
			style._makeBody
		} else {
			{ @MainActor configuration in
				AnyView(style.makeBody(configuration: configuration))
			}
		}
	}

	public func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
