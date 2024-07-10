import SwiftUI

struct AppTileStyleConfiguration {
	/// The type-erased label of an ``AppTile``.
	public struct Label: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	/// The type-erased icon of an ``AppTile``.
	public struct Icon: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	public let label: Label
	public let icon: Icon

	init(
		label: () -> some View,
		icon: () -> some View
	) {
		self.label = Label(content: label())
		self.icon = Icon(content: icon())
	}
}
