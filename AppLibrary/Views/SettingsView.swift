import LoveCore
import MoreViews
import MoreWindows
import SwiftUI

struct SettingsScene: Scene {
	@ObservedObject private var appDelegate: AppDelegate

	init(delegate: AppDelegate) {
		appDelegate = delegate
	}

	var body: some Scene {
		SettingsWindow.Window(
			SettingsWindow.Pane("Layout", tint: .gray, systemName: "circle.grid.2x2.fill", content: { LayoutPane($appDelegate.settings) }),
			SettingsWindow.Pane("Directories", tint: .gray, systemName: "list.bullet", content: { DirectoriesPane($appDelegate.state) }),
			width: SettingsWindow.defaultWidth - 100,
			sidebarWidth: SettingsWindow.defaultSidebarWidth - 50
		)
	}
}

private struct LayoutPane: View {
	@Binding private var appSettings: AppSettings

	init(_ appSettings: Binding<AppSettings>) {
		_appSettings = appSettings
	}

	var body: some View {
		Slider(value: $appSettings.columns, in: 2 ... 5, label: {
			Text("Columns")
		}, minimumValueLabel: { Text("2") }, maximumValueLabel: { Text("5") })

		Slider(value: $appSettings.sizeClass, in: 2 ... 4, label: {
			Text("Icon Size")
		})

		Slider(value: $appSettings.spacing, in: 8.0 ... 64.0, label: {
			Text("Spacing")
		})
		Slider(value: $appSettings.padding, in: 8.0 ... 32.0, label: {
			Text("Padding")
		})
	}
}

private struct DirectoriesPane: View {
	@Binding private var appState: AppState

	init(_ appState: Binding<AppState>) {
		_appState = appState
	}

	var body: some View {
		Section {
			ForEach(appState.bookmarks.urls, id: \.self) { url in
				HStack {
					Text(url.path())
					Spacer(minLength: 0)
				}
				.contentShape(Rectangle())
				.contextMenu {
					Button("Remove") { appState.bookmarks.removeBookmark(for: url) }
				}
			}
			.monospaced()
		} header: {
			HStack {
				Text("Add a directory to search for applications.")
				Button("Add Directory") { appState.bookmarks.promptForDirectory() }
			}
		}
	}
}
