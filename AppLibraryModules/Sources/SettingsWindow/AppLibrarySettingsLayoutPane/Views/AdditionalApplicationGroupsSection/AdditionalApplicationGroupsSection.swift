import AppLibraryStorage
import SwiftUI

struct AdditionalApplicationGroupsSection: View {
	public init() { }

	public var body: some View {
		Section {
			ForEach(Self.itemDisplayOrder, content: Item.init)
		} header: {
			Text("SECTION.TITLE", table: .additionalApplicationGroups)
			Text("SECTION.DESCRIPTION", table: .additionalApplicationGroups)
		}
	}
}

// MARK: - Constants

private extension AdditionalApplicationGroupsSection {
	static let itemDisplayOrder: [AdditionalApplicationGroup] = AdditionalApplicationGroup.allCases
}
