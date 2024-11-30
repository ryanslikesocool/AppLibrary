import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct LocationPane: View {
	public init() { }
}

// MARK: - SettingsPaneView

extension LocationPane: SettingsPaneView {
	public static let category: SettingsCategory = .location

	public func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: Constant.Symbol.externalDrive)
	}

	public func makeContent() -> some View {
		ApplicationSearchScopeList()
	}
}