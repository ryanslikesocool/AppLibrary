import SwiftUI
import AppLibrarySettings

struct ContentView: View {
	@Environment(\.openWindow) private var openWindow

	@ObservedObject private var appSettings: AppSettings = .shared
	@ObservedObject private var browserCache: BrowserCache = .shared

	var body: some View {
		AppList()
			.background(.separator, in: containerShape.stroke(lineWidth: 1))
			.overlay(alignment: .top) {
				SearchField()
			}
			.ignoresSafeArea()
			.appView(appSettings.display.appView)
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: BrowserViewController.cornerRadius)
	}
}
