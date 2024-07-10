import SwiftUI

struct AnyAppTileStyle: AppTileStyle {
	private var _makeBody: (Configuration) -> AnyView

	init(style: some AppTileStyle) {
		_makeBody = { configuration in
			AnyView(style.makeBody(configuration: configuration))
		}
	}

	public func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
