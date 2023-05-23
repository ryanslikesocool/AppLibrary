import LoveCore
import MoreWindows
import SwiftUI

struct GeneralSettingsPane: SettingsPaneView {
	@Binding var settings: AppSettings.General

	init(_ settings: Binding<AppSettings.General>) {
		_settings = settings
	}

	var content: some View {
		Picker("Appearance", selection: $settings.appearance) {
			ForEach(Appearance.allCases, id: \.self) { appearance in
				Text(appearance.description).tag(appearance)
				if appearance == .system {
					Divider()
				}
			}
		}
		.onChange(of: settings.appearance) { Application.dynamicAppearance = $0 }
	}
}
