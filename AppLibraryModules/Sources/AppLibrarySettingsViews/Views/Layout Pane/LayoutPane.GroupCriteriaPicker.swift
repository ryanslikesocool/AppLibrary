import AppLibraryStorage
import SwiftUI

extension LayoutPane {
	struct GroupCriteriaPicker: View {
		@Binding var selection: GroupCriteria?

		var body: some View {
			Picker("Group Criteria", selection: $selection) {
				Text("None").tag(GroupCriteria?.none)

				Section {
					Text("Category").tag(GroupCriteria?.some(.category))
				}
			}
		}
	}
}
