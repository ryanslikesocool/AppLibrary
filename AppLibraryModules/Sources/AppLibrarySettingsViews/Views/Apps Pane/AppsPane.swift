import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct AppsPane: SettingsPaneView {
	typealias Model = AppsSettings

	@ObservedObject var model: Model = .shared

	func makeLabel() -> some View {
		SwiftUI.Label("Apps", systemImage: Constant.Symbol.app)
	}

	func makeContent() -> some View {
		RefreshButton()
		HideFlagsList(model: model, selection: $model.applicationHideFlags)
	}
}
