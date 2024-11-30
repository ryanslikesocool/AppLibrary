import AppLibraryStorage
import SwiftUI

struct ApplicationGroupCriteriaPicker: View {
	public typealias SelectionValue = ApplicationGroupCriteria?

	@Binding private var selection: SelectionValue

	public init(selection: Binding<SelectionValue>) {
		_selection = selection
	}

	var body: some View {
		Picker("Group Criteria", selection: $selection) {
			makeItem(.none) {
				Text("None")
			}

			Section {
				makeItem(.category) {
					Text("Category")
				}
			}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationGroupCriteriaPicker {
	func makeItem(
		_ tag: SelectionValue,
		@ViewBuilder label: () -> some View
	) -> some View {
		label()
			.tag(tag)
	}
}