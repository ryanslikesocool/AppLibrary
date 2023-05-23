import AppKit
import LoveCore
import MoreViews
import MoreWindows
import SwiftUI

public struct SettingsScene: Scene {
	@ObservedObject private var settings: AppSettings
	private var iconTint: Color { .lerp(.gray, .white, t: 0.5) }

	public init(settings: AppSettings) {
		self.settings = settings
	}

	public var body: some Scene {
		SettingsWindow.Window(
			panes: [
				SettingsWindow.SidebarItem("General", tint: iconTint, systemName: "gearshape.fill"),
//				SettingsWindow.SidebarItem("Layout", tint: iconTint, systemName: "circle.grid.2x2.fill"),
				SettingsWindow.SidebarItem("App Directories", tint: iconTint, systemName: "folder.fill"),
				SettingsWindow.SidebarItem("Hidden Apps", tint: iconTint, systemName: "eye.slash.fill"),
			],
			width: SettingsWindow.defaultWidth - 100,
			sidebarWidth: SettingsWindow.defaultSidebarWidth - 50,
//			background: Background.init,
			detailContent: { selection in
				switch selection {
					case .some("General"): GeneralSettingsPane($settings.general)
//					case .some("Layout"): LayoutSettingsPane($settings.layout)
					case .some("App Directories"): AppDirectoriesSettingsPane($settings.appDirectories)
					case .some("Hidden Apps"): HiddenAppsSettingsPane($settings.appDirectories)
					default:
						Label("No selection...")
							.labelStyle(.emptyView())
				}
			},
			toolbar: { selection in
				switch selection {
					case let .some(item):
						SettingsWindow.ToolbarTitle("Settings  /", subtitle: item)
					default:
						Text("Settings")
							.font(.headline)
				}
			}
		)
		.onChange(of: settings.hashValue) { _ in settings.save() }
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
