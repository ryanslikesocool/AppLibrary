import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryResources
import SwiftUI

package struct AppsPane: View {
	public init() { }

	public var body: some View {
		SheetLink(
			.applicationSearchScopesList.title,
			description: .applicationSearchScopesList.form.description,
			sheetContent: ApplicationSearchScopesSheet.init
		)

		SheetLink(
			.applicationConfigurationSheet.title,
			sheetContent: ApplicationConfigurationSheet.init
		)

		RefreshApplicationsFormItem()
	}
}
