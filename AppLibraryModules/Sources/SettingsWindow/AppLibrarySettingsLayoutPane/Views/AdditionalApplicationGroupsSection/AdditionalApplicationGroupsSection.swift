import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct AdditionalApplicationGroupsSection: View {
	public init() { }

	public var body: some View {
		Section {
			ForEach(
				Self.itemDisplayOrder, id: \.self,
				content: Item.init(value:)
			)
		} header: {
			Text(.additionalApplicationGroups.section.title)
			Text(.additionalApplicationGroups.section.description)
		}
	}
}

// MARK: - Constants

private extension AdditionalApplicationGroupsSection {
	static var itemDisplayOrder: [AdditionalApplicationGroup] {
		AdditionalApplicationGroup.allCases
	}
}
