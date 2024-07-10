import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct LocationPane: SettingsPaneView {
	typealias Model = LocationSettings

	@ObservedObject var model: Model = .shared

	func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: Constant.Symbol.externalDrive)
	}

	func makeContent() -> some View {
		SearchScopeList(model: model, selection: $model.searchScopes)
	}
}
