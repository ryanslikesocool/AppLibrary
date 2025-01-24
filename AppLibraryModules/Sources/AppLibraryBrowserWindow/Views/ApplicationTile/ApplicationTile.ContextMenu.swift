import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import AppLibraryStorageViews
import SwiftUI

extension ApplicationTile {
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
				ApplicationVisibilityPicker<Text>(for: ApplicationModelIdentifier(application))
					.applicationVisibilityPickerStyle(.menuToggleList)

//				HideApplicationButton(application: application)

				if let latestInstance = application.latestInstance {
					ShowInFinderButton(latestInstance.url)
				}
			}
		}
	}
}
