import SwiftUI
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews

extension ApplicationHideFlagsList.Item {
	struct ContextMenu: View {
		@Environment(\.applicationModel) private var applicationModel

		public init() { }

		public var body: some View {
			if let url = applicationModel?.latestInstance?.url {
				ShowInFinderButton(url)
			}
		}
	}
}
