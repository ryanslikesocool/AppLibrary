import AppLibraryStorage
import SwiftUI

package struct LayoutPane: View {
	@Storage(layout: \.layout) private var layout

	public init() { }

	public var body: some View {
		LibraryLayoutPicker()

		GroupingSection()
			.disabled(layout != .grid)

		AdditionalApplicationGroupsSection()
			.disabled(layout != .grid)
	}
}
