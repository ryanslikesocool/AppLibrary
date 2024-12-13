import SwiftUI

extension ApplicationHideFlagsList.Item {
	struct HiddenInSearchToggle: View {
		@Binding private var isOn: Bool

		public init(isOn: Binding<Bool>) {
			_isOn = isOn
		}

		public var body: some View {
			Toggle(isOn: $isOn) {
				Text("ITEM.HIDE_IN_SEARCH.LABEL", table: .applicationHideFlagsList)
			}
		}
	}
}
