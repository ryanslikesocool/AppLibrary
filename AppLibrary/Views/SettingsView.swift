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
			SettingsWindow.Pane("Directories", tint: .gray, systemName: "list.bullet", content: { DirectoriesPane($appDelegate) }),
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
	@Binding private var appSettings: AppSettings

	init(_ appDelegate: ObservedObject<AppDelegate>.Wrapper) {
		_appState = appDelegate.state
		_appSettings = appDelegate.settings
	}

	var body: some View {
		Section {
			ForEach(appState.bookmarks.urls.sorted(by: \.relativeString), id: \.self) { url in
				ButtonItem(url.path()) {
					Button("Remove") { appState.bookmarks.removeBookmark(for: url) }
						.help("Remove this app directory.")
						.fontDesign(.default)
				}
				.fontDesign(.monospaced)
			}
		} header: {
			HStack {
				Text("App Directories")
				Spacer()
				Button("Add") { appState.bookmarks.promptForDirectory() }
					.font(.body)
					.help("Add a directory to search for applications.")
			}
		}

		Section {
			ForEach(appSettings.hiddenApps.sorted(), id: \.self) { app in
				ButtonItem(app) {
					Button("Show") { appSettings.hiddenApps.remove(app) }
						.help("Reveal this item in the App Library.")
				}
			}
		} header: {
			Text("Hidden Items")
		} footer: {
			Text("Items can be hidden by right clicking in the App Library and selecting \"Hide\".")
				.font(.footnote)
		}
	}

	struct ButtonItem<ButtonView: View>: View {
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
}
