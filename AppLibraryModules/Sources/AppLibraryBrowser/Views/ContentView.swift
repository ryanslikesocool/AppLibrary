import SwiftUI

struct ContentView: View {
	@State private var searchQuery: String = ""

	var body: some View {
		ZStack {
			containerShape
				.stroke(.separator, lineWidth: 1)
		}
		.overlay(alignment: .top) { // because containerRelativeFrame isn't available in macOS 13
			SearchField(searchQuery: $searchQuery)
		}
		.ignoresSafeArea()
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: BrowserViewController.cornerRadius)
	}
}
