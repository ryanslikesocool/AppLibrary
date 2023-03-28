import AppKit
import LoveCore
import MoreViews
import MoreWindows
import SwiftUI

public struct SettingsScene: Scene {
	@ObservedObject private var appSettings: AppSettings
	private var iconTint: Color { .lerp(.gray, .white, t: 0.5) }

	public init(appSettings: AppSettings) {
		self.appSettings = appSettings
	}

	public var body: some Scene {
		SettingsWindow.Window(
			SettingsWindow.Pane("General", tint: iconTint, systemName: "gearshape.fill", content: { GeneralPane($appSettings.general) }),
			// SettingsWindow.Pane("Layout", tint: .gray, systemName: "circle.grid.2x2.fill", content: { LayoutPane($appDelegate.settings) }),
			SettingsWindow.Pane("App Directories", tint: iconTint, systemName: "folder.fill", content: { AppDirectoriesPane($appSettings.appDirectories) }),
			SettingsWindow.Pane("Hidden Apps", tint: iconTint, systemName: "eye.slash.fill", content: { HiddenAppsPane($appSettings.appDirectories) }),
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

// private struct LayoutPane: View {
//	@Binding private var appSettings: AppSettings
//
//	init(_ appSettings: Binding<AppSettings>) {
//		_appSettings = appSettings
//	}
//
//	var body: some View {
//		Slider(value: $appSettings.columns, in: 2 ... 5, label: {
//			Text("Columns")
//		}, minimumValueLabel: { Text("2") }, maximumValueLabel: { Text("5") })
//
//		Slider(value: $appSettings.sizeClass, in: 2 ... 4, label: {
//			Text("Icon Size")
//		})
//
//		Slider(value: $appSettings.spacing, in: 8.0 ... 64.0, label: {
//			Text("Spacing")
//		})
//		Slider(value: $appSettings.padding, in: 8.0 ... 32.0, label: {
//			Text("Padding")
//		})
//	}
// }

private struct GeneralPane: View {
	@Binding private var settings: AppSettings.General

	init(_ settings: Binding<AppSettings.General>) {
		_settings = settings
	}

	var body: some View {
		Picker("Appearance", selection: $settings.appearance) {
			ForEach(Appearance.allCases, id: \.self) { appearance in
				Text(appearance.description).tag(appearance)
				if appearance == .system {
					Divider()
				}
			}
		}
		.onChange(of: settings.appearance) { newValue in
			NotificationCenter.default.post(name: .appearanceChanged, object: nil, userInfo: ["appearance": newValue])
		}
	}
}

private struct AppDirectoriesPane: View {
	@Binding private var settings: AppSettings.AppDirectories

	private var directoryURLs: [URL] {
		settings.appDirectories
			.compactMap { $0.url }.sorted(by: \.relativePath)
	}

	private var recommendedDirectories: [AppSettings.AppDirectories.RecommendedDirectory] {
		AppSettings.AppDirectories.recommendedDirectories
			.filter { recommendation in
				!settings.appDirectories
					.contains(where: { $0.url == recommendation.url })
			}
	}

	init(_ settings: Binding<AppSettings.AppDirectories>) {
		_settings = settings
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
							Button("Remove") {
								guard let index = settings.appDirectories.firstIndex(where: { $0.url == url }) else {
									return
								}
								settings.appDirectories.remove(at: index)
							}
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
				Button("Add") { settings.promptForDirectory() }
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
				ForEach(recommendedDirectories, id: \.self) { recommendation in
					ButtonItem(recommendation.url.path(percentEncoded: false)) {
						Button("Add") { settings.promptForDirectory(recommendation.url) }
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
	@Binding private var settings: AppSettings.AppDirectories

	private var hiddenApps: [AppIdentifier] { settings.appDirectories.flatMap { $0.apps }.filter { $0.isHidden }.sorted(by: \.description) }

	init(_ settings: Binding<AppSettings.AppDirectories>) {
		_settings = settings
	}

	var body: some View {
		Section {
			if hiddenApps.isEmpty {
				Text("No apps have been hidden.")
					.opacity(0.5)
			} else {
				LazyVStack {
					ForEach($settings.appDirectories) { $directory in
						ForEach($directory.apps) { $app in
							ButtonItem(app.description) {
								Button("Show") { app.isHidden = false }
									.help("Reveal this item in the App Library.")
									.fontDesign(.default)
							}
						}
					}
					.fontDesign(.monospaced)
//					ForEach(apps, id: \.self) { app in
//						if app != apps.last {
//							Divider()
//						}
//					}
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
