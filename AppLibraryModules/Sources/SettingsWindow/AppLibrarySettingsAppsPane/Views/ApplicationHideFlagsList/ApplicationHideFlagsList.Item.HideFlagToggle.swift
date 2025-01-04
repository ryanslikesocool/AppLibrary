import AppLibraryCommon
import SwiftUI

extension ApplicationHideFlagsList.Item {
	struct HideFlagToggle: View {
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

private extension ApplicationHideFlagsList.Item.HideFlagToggle {
	func makeTitleText() -> String {
		let flagName = String(localized: flagName)
		return LocalizedStringResource.applicationHideFlagsList.item.format.verb(flagName)
	}
}
