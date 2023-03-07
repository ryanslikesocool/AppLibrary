import LoveCore
import MoreViews
import SwiftUI

struct ContentView: View {
	@Environment(\.openWindow) private var openWindow
	@EnvironmentObject private var appDelegate: AppDelegate
	@State private var libraryStyle: LibraryStyle = .list

	var body: some View {
		content
			.overlay(alignment: .bottomTrailing) { settingsButton }
	}

	@ViewBuilder private var content: some View {
		if appDelegate.state.bookmarks.isEmpty {
			GrantPermissionsView()
		} else {
			AppListView()
				.libraryStyle(libraryStyle)
				.frame(maxHeight: 450)
				.background { KeyboardHandlerView() }
//				.overlay(alignment: .bottom) {
//					stylePicker
//				}
		}
	}

	private var settingsButton: some View {
		Button(action: {
			openWindow(id: "settings")
		}) {
			Image(systemName: "gearshape.fill")
				.padding(8)
				.contentShape(Rectangle())
		}
		.opacity(0.5)
		.buttonStyle(.plain)
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
