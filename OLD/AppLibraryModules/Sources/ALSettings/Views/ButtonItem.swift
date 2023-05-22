import SwiftUI

struct ButtonItem<ButtonView: View>: View {
	@State private var hovering: Bool = false
	private let name: String
	private let button: () -> ButtonView

	init(_ name: String, @ViewBuilder button: @escaping () -> ButtonView) {
		self.name = name
		self.button = button
	}

	var body: some View {
		LabeledContent(name) {
			button()
				.opacity(hovering ? 1 : 0)
		}
		.contentShape(Rectangle())
		.onHover { hovering = $0 }
	}
}
