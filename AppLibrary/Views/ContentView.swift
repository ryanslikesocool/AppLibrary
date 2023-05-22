import SwiftUI

struct ContentView: View {
	@State private var searchQuery: String = ""

	var body: some View {
		VStack {
			ScrollView {
				Spacer()
					.frame(height: 52)

				LazyVStack(alignment: .leading, spacing: 0) {
					ForEach(0 ..< 10, id: \.self) { _ in
						AppTile()
					}
				}

				Spacer()
					.frame(height: 8)
			}
			.scrollIndicators(.never)
			.padding(.horizontal, 8)
		}
		.overlay(alignment: .top) { SearchBar(query: $searchQuery) }
		.ignoresSafeArea()
	}
}
