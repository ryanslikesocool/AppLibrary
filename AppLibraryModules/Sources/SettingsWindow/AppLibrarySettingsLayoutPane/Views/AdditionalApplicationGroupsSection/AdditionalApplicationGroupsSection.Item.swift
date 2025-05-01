import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension AdditionalApplicationGroupsSection {
	struct Item: View {
		public typealias SelectionValue = AdditionalApplicationGroup

		@Storage(layout: \.additionalGroups) private var additionalGroups

		private let value: SelectionValue

		public init(value: SelectionValue) {
			self.value = value
		}

		public var body: some View {
			if let displayRepresentation = SelectionValue.caseDisplayRepresentations[value] {
				Toggle(isOn: $additionalGroups[SelectionValue.Set(value)]) {
					Text(displayRepresentation.title)
					Text(displayRepresentation.subtitle)
				}
			}
		}
	}
}
