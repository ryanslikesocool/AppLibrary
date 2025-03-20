import AppLibraryCommonViews
import SwiftUI

extension ApplicationSearchScopesSheet {
	struct Toolbar: ToolbarContent {
		public init() { }

		public var body: some ToolbarContent {
			ToolbarItem {
				ControlGroup {
					ApplicationSearchScopesList.AddMenu()
					ApplicationSearchScopesList.RemoveButton()
				}
			}

			ToolbarItem(placement: .confirmationAction) {
				SheetDoneButton()
			}
		}
	}
}
