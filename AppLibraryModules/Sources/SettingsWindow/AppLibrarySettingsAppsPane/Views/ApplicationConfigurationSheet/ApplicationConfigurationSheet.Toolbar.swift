import AppLibraryCommonViews
import SwiftUI

extension ApplicationConfigurationSheet {
	struct Toolbar: ToolbarContent {
		public init() { }

		public var body: some ToolbarContent {
			ToolbarItem(placement: .confirmationAction) {
				SheetDoneButton()
			}
		}
	}
}
