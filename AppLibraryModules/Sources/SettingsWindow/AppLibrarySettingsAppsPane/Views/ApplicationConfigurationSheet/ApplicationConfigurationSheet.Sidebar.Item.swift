import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension ApplicationConfigurationSheet.Sidebar {
	struct Item: View {
		private let applicationModel: ApplicationModel

		public init(for applicationModel: ApplicationModel) {
			self.applicationModel = applicationModel
		}

		public var body: some View {
			NavigationLink(value: ApplicationModelIdentifier(applicationModel)) {
				ApplicationLabel(for: applicationModel)
					.contextMenu {
						ContextMenu(for: applicationModel)
					}
			}
		}
	}
}
