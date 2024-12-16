import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct AdditionalApplicationGroupsSection: View {
	public init() { }

	public var body: some View {
		Section {
			ForEach(Self.itemDisplayOrder, content: Item.init)
		} header: {
			Text(.additionalApplicationGroups.section.title)
			Text(.additionalApplicationGroups.section.description)
		}
	}
}

// MARK: - Constants

private extension AdditionalApplicationGroupsSection {
	static let itemDisplayOrder: [AdditionalApplicationGroup] = AdditionalApplicationGroup.allCases
}
