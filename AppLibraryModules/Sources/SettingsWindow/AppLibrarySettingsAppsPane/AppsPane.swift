import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryResources
import SwiftUI

package struct AppsPane: View {
	public init() { }

	public var body: some View {
		SheetFormItem(
			title: .applicationSearchScopesList.title,
			description: .applicationSearchScopesList.form.description,
			sheetContent: ApplicationSearchScopesSheet.init
		)

		SheetFormItem(
			title: .applicationVisibilityList.title,
			description: .applicationVisibilityList.form.description,
			sheetContent: ApplicationHideFlagsSheet.init
		)
		
		RefreshApplicationsFormItem()
	}
}
