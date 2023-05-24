import SwiftUI

struct SearchBar: View {
	@Environment(\.colorScheme) private var colorScheme
	@Binding var query: String

	var body: some View {
		TextField("􀊫 App Library", text: $query)
			.textFieldStyle(.plain)
			.font(.title3)
			.padding(.horizontal, 8)
			.frame(height: 36)
			.frame(maxWidth: .infinity)
			.background(.thinMaterial, in: containerShape)
			.overlay(.separator, in: containerShape.stroke(lineWidth: 1))
			.padding(8)
			.compositingGroup()
			.shadowRcp(color: .black.opacity(colorScheme == .dark ? 0.5 : 0.25), radius: 16, x: 0, y: 8, base: 0.8)
	}

	private var containerShape: some Shape {
		RoundedRectangle(cornerRadius: 8, style: .continuous)
	}
}
