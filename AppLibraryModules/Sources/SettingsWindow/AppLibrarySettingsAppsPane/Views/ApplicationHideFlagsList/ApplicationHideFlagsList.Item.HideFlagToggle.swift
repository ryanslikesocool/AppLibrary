import LocalizationTable
import AppLibraryCommon
import SwiftUI

extension ApplicationHideFlagsList.Item {
	struct HideFlagToggle: View {
		@Binding private var isOn: Bool

		private let flagNameKey: String.LocalizationValue

		public init(_ flagNameKey: String.LocalizationValue, isOn: Binding<Bool>) {
			self.flagNameKey = flagNameKey
			_isOn = isOn
		}

		public var body: some View {
			Toggle(isOn: $isOn) {
				Text(verbatim: makeTitleText())
			}
		}
	}
}

// MARK: - Functions

private extension ApplicationHideFlagsList.Item.HideFlagToggle {
	func makeTitleText() -> String {
		let localizationTable: LocalizationTableResource = .applicationHideFlagsList
		let flagName = String(localized: flagNameKey, table: localizationTable)
		return String(localized: .applicationHideFlagsList.item.format.verb(flagName), table: localizationTable)
	}
}
