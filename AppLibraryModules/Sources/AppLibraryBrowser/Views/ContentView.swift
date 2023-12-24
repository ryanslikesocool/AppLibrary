import SwiftUI

struct ContentView: View {
	var body: some View {
		ZStack {
			containerShape
				.stroke(.separator, lineWidth: 1)
		}
		.ignoresSafeArea()
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: BrowserViewController.cornerRadius)
	}
}
