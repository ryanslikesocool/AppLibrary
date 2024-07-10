import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct GeneralPane: SettingsPaneView {
	typealias Model = GeneralSettings

	@ObservedObject var model: Model = .shared

	func makeLabel() -> some View {
		SwiftUI.Label("General", systemImage: Constant.Symbol.gearShape)
	}

	func makeContent() -> some View {
		AppearancePicker(selection: $model.appearance)
	}
}
