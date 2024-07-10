import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct ContextMenu: View {
		private let application: Application

		init(for application: Application) {
			self.application = application
		}

		var body: some View {
			Section {
				Button("Open", systemImage: Constant.Symbol.arrow_up_forward, action: application.open)
			}
			Section {
				Button("Hide", systemImage: Constant.Symbol.eye_slash, action: application.hide)
				Button.showInFinder(application.url)
			}
		}
	}
}
