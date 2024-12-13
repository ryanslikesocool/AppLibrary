import SwiftUI

struct GroupingSection: View {
	public init() { }

	public var body: some View {
		Section {
			ApplicationGroupCriteriaPicker()
		} header: {
			Text("Grouping")
			Text(#"Grouping is only available in the "Grid" layout."#)
		}
	}
}