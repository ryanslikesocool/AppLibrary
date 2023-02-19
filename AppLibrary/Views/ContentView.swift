import LoveCore
import MoreViews
import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var appDelegate: AppDelegate
	@State private var libraryStyle: LibraryStyle = .list

	var body: some View {
		content
			.background(Material.thin)
			.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous), style: .init(antialiased: true))
			.ignoresSafeArea()
			.accessWindow(onAppear: applyWindowStyle)
	}

	@ViewBuilder private var content: some View {
		if appDelegate.state.bookmarks.isEmpty {
			GrantPermissionsView()
		} else {
			AppListView()
				.libraryStyle(libraryStyle)
//				.overlay(alignment: .bottom) {
//					stylePicker
//				}
		}
	}

	private func applyWindowStyle(window: NSWindow) {
		window.styleMask = [.borderless, .titled, .closable, .fullSizeContentView]
		// remove titled for border thingy fix

		window.titlebarAppearsTransparent = true
		window.titleVisibility = .hidden
		window.backgroundColor = .clear

		window.standardWindowButton(.closeButton)?.isHidden = true
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.zoomButton)?.isHidden = true

		window.center()

//		if let dockRect = window.dockTile.contentView?.bounds {
//			let screenRect = window.convertToScreen(dockRect)
//			print(screenRect)
//		}
	}

	private var stylePicker: some View {
		Picker("", selection: $libraryStyle) {
			Text("Tile")
				.tag(LibraryStyle.tile)

			Text("List")
				.tag(LibraryStyle.list)
		}
//		.controlSize(.large)
		.labelsHidden()
		.frame(maxWidth: 200)
		.pickerStyle(.segmented)
		.padding(8)
		.background(Material.regular, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
		.padding(8)
		.compositingGroup()
		.shadow(radius: 4, y: 2)
	}
}
