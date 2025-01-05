import SwiftUI

struct ApplicationTileStyleConfiguration {
	public let label: Label
	public let icon: Icon

	@MainActor
	init(
		label: some View,
		icon: some View
	) {
		self.label = Label(label)
		self.icon = Icon(icon)
	}
}

// MARK: - Supporting Data

extension ApplicationTileStyleConfiguration {
	/// The type-erased label of an ``AppTile``.
	public struct Label: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public let body: AnyView
	}

	/// The type-erased icon of an ``AppTile``.
	public struct Icon: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public let body: AnyView
	}
}
