import SwiftUI

struct GroupingSection: View {
	public init() { }

	public var body: some View {
		Section {
			ApplicationGroupCriteriaPicker()
		} header: {
			Text(.applicationGroupSection.title)
			Text(.applicationGroupSection.description)
		}
	}
}
