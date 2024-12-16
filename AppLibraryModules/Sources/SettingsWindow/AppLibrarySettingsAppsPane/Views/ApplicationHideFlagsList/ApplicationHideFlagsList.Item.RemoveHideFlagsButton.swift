import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

extension ApplicationHideFlagsList.Item {
	struct RemoveHideFlagsButton: View {
		private let action: () -> Void

		public init(action: @escaping () -> Void) {
			self.action = action
		}

		public var body: some View {
			Button(action: action) {
				Label {
					Text(.common.action.reveal)
				} icon: {
					Image(systemName: Constant.Symbol.eye)
				}
			}
		}
	}
}
