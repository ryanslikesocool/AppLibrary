import AppLibraryStorage
import SwiftUI

struct RecentlyUpdatedGroupToggle: View {
	@Binding private var isOn: Bool

	public init(isOn: Binding<Bool>) {
		_isOn = isOn
	}

	public var body: some View {
		Toggle(isOn: $isOn) {
			Text("Recently Updated")
			Text("Add a group with apps that have been updated in the last week.")
		}
	}
}
