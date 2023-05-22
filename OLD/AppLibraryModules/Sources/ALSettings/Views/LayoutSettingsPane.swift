import MoreWindows
import SwiftUI

// private struct LayoutSettingsPane: SettingsPaneView {
//	@Binding var settings: AppSettings.Layout
//
//	init(_ appSettings: Binding<AppSettings>) {
//		_appSettings = appSettings
//	}
//
//	var content: some View {
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
