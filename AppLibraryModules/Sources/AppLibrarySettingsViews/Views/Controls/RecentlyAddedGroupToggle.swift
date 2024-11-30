import AppLibraryStorage
import SwiftUI

struct RecentlyAddedGroupToggle: View {
	@Binding private var isOn: Bool

	public init(isOn: Binding<Bool>) {
		_isOn = isOn
	}

	public var body: some View {
		Toggle(isOn: $isOn) {
			Text("Recently Added")
			Text("Add a group with apps that have been added in the last week.")
		}
	}
}
