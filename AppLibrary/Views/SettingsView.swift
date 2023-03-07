import AppKit
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
			SettingsWindow.Pane("General", tint: .gray, systemName: "gearshape.fill", content: { GeneralPane($appDelegate.settings) }),
			// SettingsWindow.Pane("Layout", tint: .gray, systemName: "circle.grid.2x2.fill", content: { LayoutPane($appDelegate.settings) }),
			SettingsWindow.Pane("Directories", tint: .gray, systemName: "folder.fill", content: { DirectoriesPane($appDelegate.state) }),
			SettingsWindow.Pane("Hidden Apps", tint: .gray, systemName: "eye.slash.fill", content: { HiddenAppsPane($appDelegate.settings) }),
			width: SettingsWindow.defaultWidth - 100,
			sidebarWidth: SettingsWindow.defaultSidebarWidth - 50,
			background: Background.init
		)
	}
}

private struct Background: View {
	@State private var window: NSWindow?

	var body: some View {
		Color.clear
			.accessWindow { self.window = $0 }
			.onAppear {
				Threading.main {
					NSApp.setActivationPolicy(.regular)
					window?.center()
				}
			}
			.toolbar {
				Spacer()
				Button(action: { NSApp.terminate(nil) }) {
					Image(systemName: "power")
				}
				.help("Quit App Library")
			}
			.onReceive(NSWindow.willCloseNotification.publisher()) { _ in
				NSApp.setActivationPolicy(.accessory)
			}
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

private struct GeneralPane: View {
	@Binding private var appSettings: AppSettings

	init(_ appSettings: Binding<AppSettings>) {
		_appSettings = appSettings
	}

	var body: some View {
		Picker("Appearance", selection: $appSettings.appearance) {
			Text("System").tag("System")
			Divider()
			Text("Light").tag("Light")
			Text("Dark").tag("Dark")
		}
		.onChange(of: appSettings.appearance) { newValue in
			NotificationCenter.default.post(name: .appearanceChanged, object: nil, userInfo: ["appearance": newValue])
		}

//		Toggle(isOn: $appSettings.globalHotkey) {
//			Text("Global Hotkey")
//			HStack {
//				Text("Open the App Library from anywhere with")
//				Text("⇧ ⌘ Space")
//					.monospaced()
//			}
//		}
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
		Text("App Library requires explicit permission from you before it is able to view the contents of directories.")

		Section {
			if directoryURLs.isEmpty {
				Text("No application directories have been added.")
					.opacity(0.5)
			} else {
				LazyVStack {
					let urls = directoryURLs

					ForEach(urls, id: \.self) { url in
						ButtonItem(url.compressingTildeInPath) {
							Button("Remove") { appState.bookmarks.removeBookmark(for: url) }
								.help("Remove this app directory.")
								.fontDesign(.default)
						}

						if url != urls.last {
							Divider()
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
			Text("Each Application Directory is scanned for apps to display in the App Library.  Subdirectories are not scanned.")
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
					let apps = hiddenApps

					ForEach(apps, id: \.self) { app in
						ButtonItem(app) {
							Button("Show") { appSettings.hiddenApps.remove(app) }
								.help("Reveal this item in the App Library.")
								.fontDesign(.default)
						}

						if app != apps.last {
							Divider()
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
