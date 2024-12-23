import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct ContextMenu: View {
		private let application: ApplicationModel

		public init(for application: ApplicationModel) {
			self.application = application
		}

		public var body: some View {
			Section {
				Button("Open", systemImage: Constant.Symbol.arrow_up_forward, action: application.openLatest)
			}
			Section {
				Button("Hide", systemImage: Constant.Symbol.eye_slash, action: application.hide)

				if let latestInstance = application.latestInstance {
					ShowInFinderButton(latestInstance.url)
				}
			}
		}
	}
}
