import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct ContextMenu: View {
		@ObservedObject private var application: ApplicationModel

		public init(for application: ApplicationModel) {
			self.application = application
		}

		public var body: some View {
			Section {
				OpenApplicationButton(application: application)
			}
			Section {
				HideApplicationButton(application: application)

				if let latestInstance = application.latestInstance {
					ShowInFinderButton(latestInstance.url)
				}
			}
		}
	}
}
