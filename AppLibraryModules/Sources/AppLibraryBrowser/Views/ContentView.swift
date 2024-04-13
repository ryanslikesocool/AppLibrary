import AppLibrarySettings
import AppLibraryStorage
import SwiftUI

struct ContentView: View {
	@Environment(\.openWindow) private var openWindow

	@ObservedObject private var appSettings: AppSettings = .shared
	@ObservedObject private var browserModel: BrowserModel = .shared

	var body: some View {
		AppBrowser()
			.background(.separator, in: containerShape.stroke(lineWidth: 1))
			.overlay(alignment: .top) {
				SearchField()
			}
			.ignoresSafeArea()
			.libraryLayout(appSettings.display.libraryLayout)
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: BrowserViewController.cornerRadius)
	}
}
