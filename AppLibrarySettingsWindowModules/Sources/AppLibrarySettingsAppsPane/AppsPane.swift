import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

package struct AppsPane: View {
	public init() { }

	public var body: some View {
		RefreshAppsSection()
		
		ApplicationHideFlagsList()
	}
}
