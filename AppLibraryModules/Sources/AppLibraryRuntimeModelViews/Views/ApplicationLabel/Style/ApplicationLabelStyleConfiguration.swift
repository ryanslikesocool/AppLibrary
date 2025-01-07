import SwiftUI

public struct ApplicationLabelStyleConfiguration {
	public let title: Text
	public let icon: Icon

	@MainActor
	init(
		title: Text,
		icon: some View
	) {
		self.title = title
		self.icon = Icon(icon)
	}
}

// MARK: - Supporting Data

public extension ApplicationLabelStyleConfiguration {
	/// The type-erased icon of an ``ApplicationLabel``.
	struct Icon: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public let body: AnyView
	}
}
