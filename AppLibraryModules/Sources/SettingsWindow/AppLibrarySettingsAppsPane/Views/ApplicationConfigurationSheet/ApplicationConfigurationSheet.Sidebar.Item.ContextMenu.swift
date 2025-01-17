import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension ApplicationConfigurationSheet.Sidebar.Item {
	struct ContextMenu: View {
		private let applicationModelIdentifier: ApplicationModelIdentifier

		public init(for applicationModelIdentifier: ApplicationModelIdentifier) {
			self.applicationModelIdentifier = applicationModelIdentifier
		}

		public var body: some View {
			ShowInFinderButton(latestInstance: applicationModelIdentifier)
		}
	}
}