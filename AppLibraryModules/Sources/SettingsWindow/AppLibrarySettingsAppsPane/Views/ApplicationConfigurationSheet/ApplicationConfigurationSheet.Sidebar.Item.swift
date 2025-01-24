import AppLibraryStorage
import AppLibraryRuntimeModelViews
import SwiftUI

extension ApplicationConfigurationSheet.Sidebar {
	struct Item: View {
		private let applicationModelIdentifier: ApplicationModelIdentifier

		public init(for applicationModelIdentifier: ApplicationModelIdentifier) {
			self.applicationModelIdentifier = applicationModelIdentifier
		}

		public var body: some View {
			NavigationLink(value: applicationModelIdentifier) {
				ApplicationLabel(for: applicationModelIdentifier)
					.contextMenu {
						ContextMenu(for: applicationModelIdentifier)
					}
			}
		}
	}
}
