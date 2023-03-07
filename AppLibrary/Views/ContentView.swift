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
		Group {
			if appDelegate.state.bookmarks.isEmpty {
				GrantPermissionsView()
			} else {
				AppListView()
					.libraryStyle(libraryStyle)
					.frame(maxHeight: 450)
					.background { KeyboardHandlerView() }
			}
		}
		.overlay {
			Superellipse(radius: 16)
				.stroke(Color.separator, lineWidth: 3)
		}
		.accessWindow { window in
			window.hasShadow = false

			if let layer = window.contentView?.layer {
				layer.cornerRadius = 16
				layer.cornerCurve = CALayerCornerCurve.continuous
				layer.masksToBounds = true
			}

//			window.center()
		}
		.compositingGroup()
	}

	private func recurseSubviews(view: NSView, safe: Bool, body: @escaping (NSView, Bool) -> Bool) {
		let safe = body(view, safe)
		for subview in view.subviews {
			recurseSubviews(view: subview, safe: safe, body: body)
		}
	}

	private var settingsButton: some View {
		Button(action: {
			NSApp.activate(ignoringOtherApps: true)
			openWindow(id: "settings")
		}) {
			Image(systemName: "gearshape.fill")
				.padding(8)
				.contentShape(Rectangle())
		}
		.opacity(0.5)
		.buttonStyle(.plain)
	}

//	private var stylePicker: some View {
//		Picker("", selection: $libraryStyle) {
//			Text("Tile")
//				.tag(LibraryStyle.tile)
//
//			Text("List")
//				.tag(LibraryStyle.list)
//		}
//		.labelsHidden()
//		.frame(maxWidth: 200)
//		.pickerStyle(.segmented)
//		.padding(8)
//		.background(Material.regular, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
//		.padding(8)
//		.compositingGroup()
//		.shadow(radius: 4, y: 2)
//	}
}

private struct ClippingView: View {
	var body: some View {
		Color.clear
			.superellipseClipShape(radius: 32)
	}
}
