import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

extension AppsPane {
	struct RefreshButton: View {
		var body: some View {
			LabeledContent {
				Button(action: { Event.refreshApps() }, label: SwiftUI.Label.refresh)
			} label: {
				Text("Refresh")
				Text("Use ⌘ + R to refresh the list while the Library is focused.")
			}
		}
	}
}
