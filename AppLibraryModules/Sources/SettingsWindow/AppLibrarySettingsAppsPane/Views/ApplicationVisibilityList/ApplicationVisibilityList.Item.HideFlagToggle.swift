import AppLibraryCommon
import SwiftUI

extension ApplicationVisibilityList.Item {
	struct VisibilityFlagToggle: View {
		@Binding private var isOn: Bool

		private let flagName: LocalizedStringResource

		public init(_ flagName: LocalizedStringResource, isOn: Binding<Bool>) {
			self.flagName = flagName
			_isOn = isOn
		}

		public var body: some View {
			Toggle(
				makeTitleText(),
				isOn: $isOn
			)
		}
	}
}

// MARK: - Functions

private extension ApplicationVisibilityList.Item.VisibilityFlagToggle {
	func makeTitleText() -> String {
		let flagName = String(localized: flagName)
		return LocalizedStringResource.applicationVisibilityList.item.format.pastParticiple(flagName)
	}
}
