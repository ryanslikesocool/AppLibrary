import SwiftUI

struct SearchBar: View {
	@Environment(\.colorScheme) private var colorScheme
	@Binding var query: String

	var body: some View {
		ZStack {
			TextField("􀊫 App Library", text: $query)
				.textFieldStyle(.plain)
		}
		.padding(.horizontal, 8)
		.font(.title3)
		.frame(height: 36)
		.background(.thinMaterial, in: containerShape)
		.overlay(.separator, in: containerShape.stroke(lineWidth: 1))
		.frame(maxWidth: .infinity)
		.padding(8)
		.compositingGroup()
		.betterShadow(color: .black.opacity(colorScheme == .dark ? 0.5 : 0.25), radius: 16, x: 0, y: 8)
	}

	private var containerShape: some Shape {
		RoundedRectangle(cornerRadius: 8, style: .continuous)
	}
}
