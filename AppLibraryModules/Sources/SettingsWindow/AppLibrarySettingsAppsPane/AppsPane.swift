import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

package struct AppsPane: View {
	public init() { }

	public var body: some View {
		SheetFormItem(table: .applicationSearchScopesList, sheetContent: ApplicationSearchScopesSheet.init)
		SheetFormItem(table: .applicationHideFlagsList, sheetContent: ApplicationHideFlagsSheet.init)
		RefreshApplicationsFormItem()
	}
}
