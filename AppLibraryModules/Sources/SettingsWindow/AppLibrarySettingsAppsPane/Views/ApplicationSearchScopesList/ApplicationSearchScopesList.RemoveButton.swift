import AppLibraryCommonViews
import SwiftUI

extension ApplicationSearchScopesList {
	struct RemoveButton: View {
		@Environment(\.delete) private var delete

		public init() { }

		public var body: some View {
			Button(role: .destructive) {
				delete?()
			} label: {
				Label(
					.common.action.remove,
					systemImage: .minus
				)
			}
			.disabled(delete == nil)
		}
	}
}
