import AppLibraryStorage
import SwiftUI

extension LayoutPane {
	struct RecentlyUpdatedGroupToggle: View {
		@Binding var isOn: Bool

		var body: some View {
			Toggle(isOn: $isOn) {
				Text("Recently Updated")
				Text("Add a group with apps that have been updated in the last week.")
			}
		}
	}
}
