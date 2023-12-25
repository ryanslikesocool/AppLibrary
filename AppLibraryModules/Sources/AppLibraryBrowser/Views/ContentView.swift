import SwiftUI
import AppLibrarySettings

struct ContentView: View {
	@ObservedObject private var appSettings: AppSettings = .shared
	@State private var searchQuery: String = ""

	var body: some View {
		AppList(searchQuery: searchQuery)
			.background(.separator, in: containerShape.stroke(lineWidth: 1))
			.overlay(alignment: .top) {
				SearchField(searchQuery: $searchQuery)
			}
			.ignoresSafeArea()
			.appView(appSettings.display.appView)
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: BrowserViewController.cornerRadius)
	}
}
