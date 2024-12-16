import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

extension AdditionalApplicationGroupsSection {
	struct Item: View {
		typealias SelectionValue = AdditionalApplicationGroup

		@Storage(layout: \.additionalGroups) private var additionalGroups

		private let group: SelectionValue

		public init(group: SelectionValue) {
			self.group = group
		}

		public var body: some View {
			Toggle(isOn: $additionalGroups[SelectionValue.Set(group)]) {
				Text(group.labelKey)
				Text(group.descriptionKey)
			}
		}
	}
}

// MARK: -

private extension AdditionalApplicationGroupsSection.Item.SelectionValue {
	var labelKey: LocalizedStringResource {
		switch self {
			case .recentlyAdded: .additionalApplicationGroups.item.recentlyAdded.label
			case .recentlyUpdated: .additionalApplicationGroups.item.recentlyUpdated.label
		}
	}

	var descriptionKey: LocalizedStringResource {
		switch self {
			case .recentlyAdded: .additionalApplicationGroups.item.recentlyAdded.description
			case .recentlyUpdated: .additionalApplicationGroups.item.recentlyUpdated.description
		}
	}
}
