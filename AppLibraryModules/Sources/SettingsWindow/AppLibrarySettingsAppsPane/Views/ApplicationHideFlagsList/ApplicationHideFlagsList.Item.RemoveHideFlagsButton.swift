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
				Label(.common.action.reveal, systemImage: .eye)
			}
		}
	}
}
