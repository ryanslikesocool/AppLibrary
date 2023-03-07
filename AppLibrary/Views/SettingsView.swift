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
			//			SettingsWindow.Pane("Layout", tint: .gray, systemName: "circle.grid.2x2.fill", content: { LayoutPane($appDelegate.settings) }),
			SettingsWindow.Pane("Directories", tint: .gray, systemName: "folder", content: { DirectoriesPane($appDelegate.state) }),
			SettingsWindow.Pane("Hidden Apps", tint: .gray, systemName: "eye.slash", content: { HiddenAppsPane($appDelegate.settings) }),
			width: SettingsWindow.defaultWidth - 100,
			sidebarWidth: SettingsWindow.defaultSidebarWidth - 50,
			background: {
				Color.clear
					.accessWindow { window in
						Timer.delay(for: 0.5) {
							Threading.main {
								window.makeKeyAndOrderFront(nil)
								window.center()
							}
						}
					}
					.toolbar {
						Spacer()
						Button(action: { NSApp.terminate(nil) }) {
							Image(systemName: "power")
						}
						.help("Quit App Library")
					}
			}
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

	private var directoryURLs: [URL] { appState.bookmarks.urls.sorted(by: \.relativePath) }
	private var recommendedDirectories: [String] { AppState.recommendedURLs.filter { recommendation in !appState.bookmarks.urls.contains(where: { $0.compressingTildeInPath == recommendation }) } }

	init(_ appState: Binding<AppState>) {
		_appState = appState
	}

	var body: some View {
		Text("Each Application Directory is scanned for apps to display in the App Library.  Subdirectories are not scanned.\n\nApp Library requires explicit permission from you before it is able to view the contents of directories.")

		Section {
			if directoryURLs.isEmpty {
				Text("No application directories have been added.")
					.opacity(0.5)
			} else {
				LazyVStack {
					ForEach(directoryURLs, id: \.self) { url in
						ButtonItem(url.compressingTildeInPath) {
							Button("Remove") { appState.bookmarks.removeBookmark(for: url) }
								.help("Remove this app directory.")
								.fontDesign(.default)
						}
					}
					.fontDesign(.monospaced)
				}
			}
		} header: {
			HStack {
				Text("Application Directories")
				Spacer()
				Button("Add") { appState.bookmarks.promptForDirectory() }
					.font(.body)
					.help("Add a directory to search for applications.")
			}
		}

		Section {
			if recommendedDirectories.isEmpty {
				Text("All recommendations have been added.")
					.opacity(0.5)
			} else {
				ForEach(recommendedDirectories, id: \.self) { url in
					ButtonItem(url) {
						Button("Add") { appState.bookmarks.promptForDirectory(URL(string: url)) }
							.help("Add this recommended directory to the application directory list.")
							.fontDesign(.default)
					}
				}
				.fontDesign(.monospaced)
			}
		} header: {
			Text("Recommended Directories")
			Text("These directories are recommended for the best experience using App Library.")
		}
	}
}

private struct HiddenAppsPane: View {
	@Binding private var appSettings: AppSettings

	private var hiddenApps: [String] { appSettings.hiddenApps.sorted() }

	init(_ appSettings: Binding<AppSettings>) {
		_appSettings = appSettings
	}

	var body: some View {
		Section {
			if hiddenApps.isEmpty {
				Text("No apps have been hidden.")
					.opacity(0.5)
			} else {
				LazyVStack {
					ForEach(hiddenApps, id: \.self) { app in
						ButtonItem(app) {
							Button("Show") { appSettings.hiddenApps.remove(app) }
								.help("Reveal this item in the App Library.")
								.fontDesign(.default)
						}
					}
					.fontDesign(.monospaced)
				}
			}
		} header: {
			Text("Hidden Apps")
			Text("Apps can be hidden from the App Library by right clicking them and selecting \"Hide\".")
		}
	}
}

private struct ButtonItem<ButtonView: View>: View {
	@State private var hovering: Bool = false
	private let name: String
	private let button: () -> ButtonView

	init(_ name: String, @ViewBuilder button: @escaping () -> ButtonView) {
		self.name = name
		self.button = button
	}

	var body: some View {
		LabeledContent(name) {
			button()
				.opacity(hovering ? 1 : 0)
		}
		.contentShape(Rectangle())
		.onHover { hovering = $0 }
	}
}
