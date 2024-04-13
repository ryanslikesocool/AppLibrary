import AppLibraryCommon
import AppLibraryStorage
import OSLog
import SwiftUI

struct DirectoriesPane: SettingsPaneView {
	static var tab: SettingsTab { .directories }

	@Binding var model: AppSettings.Directories

	var content: some View {
		SearchScopeList(model: $model)
	}
}
