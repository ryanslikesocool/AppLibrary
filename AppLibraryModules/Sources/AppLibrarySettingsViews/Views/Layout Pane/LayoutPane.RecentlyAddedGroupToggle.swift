import AppLibraryStorage
import SwiftUI

extension LayoutPane {
	struct RecentlyAddedGroupToggle: View {
		@Binding var isOn: Bool

		var body: some View {
			Toggle(isOn: $isOn) {
				Text("Recently Added")
				Text("Add a group with apps that have been added in the last week.")
			}
		}
	}
}
