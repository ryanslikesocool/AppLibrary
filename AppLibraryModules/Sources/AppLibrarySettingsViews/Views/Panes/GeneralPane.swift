import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct GeneralPane: View {
	public init() { }
}

// MARK: - SettingsPaneView

extension GeneralPane: SettingsPaneView {
	public static let category: SettingsCategory = .general

	public func makeLabel() -> some View {
		SwiftUI.Label("General", systemImage: Constant.Symbol.gearShape)
	}

	public func makeContent() -> some View {
		AppearancePicker()
	}
}