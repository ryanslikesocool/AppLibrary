import MoreWindows
import SwiftUI

struct HiddenAppsSettingsPane: SettingsPaneView {
	@Binding var settings: AppSettings.AppDirectories

	private var hiddenApps: [AppIdentifier] { settings.appDirectories.flatMap { $0.apps }.filter { $0.isHidden }.sorted(by: \.description) }

	init(_ settings: Binding<AppSettings.AppDirectories>) {
		_settings = settings
	}

	var content: some View {
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
