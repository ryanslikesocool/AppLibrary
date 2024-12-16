import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

package struct AppsPane: View {
	public init() { }

	public var body: some View {
		SheetFormItem(title: .applicationSearchScopesList.title, description: .applicationSearchScopesList.form.description, table: .applicationSearchScopesList, sheetContent: ApplicationSearchScopesSheet.init)
		SheetFormItem(title: .applicationHideFlagsList.title, description: .applicationHideFlagsList.form.description, table: .applicationHideFlagsList, sheetContent: ApplicationHideFlagsSheet.init)
		RefreshApplicationsFormItem()
	}
}
