import AppLibraryStorage
import SwiftUI

struct AppsPane: SettingsPaneView {
	static var tab: SettingsTab { .apps }
	
	@Binding var model: AppSettings.Apps

	var content: some View {
		HiddenAppsList(model: $model)
	}
}
