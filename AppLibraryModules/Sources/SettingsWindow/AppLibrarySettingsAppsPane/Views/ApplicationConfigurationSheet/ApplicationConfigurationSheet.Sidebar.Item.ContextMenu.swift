import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension ApplicationConfigurationSheet.Sidebar.Item {
	struct ContextMenu: View {
		private let applicationModel: ApplicationModel

		public init(for applicationModel: ApplicationModel) {
			self.applicationModel = applicationModel
		}

		public var body: some View {
			ShowInFinderButton(latestInstance: applicationModel)
		}
	}
}
