import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension ApplicationHideFlagsList {
	struct Item: View {
		public typealias SelectionValue = ApplicationHideFlag.Set

		private let application: ApplicationIdentifier
		@Binding private var activeFlags: SelectionValue
		private let removeHideFlags: () -> Void

		public init(
			application: ApplicationIdentifier,
			selection: Binding<SelectionValue>,
			onRemove removeHideFlags: @escaping () -> Void
		) {
			self.application = application
			self.removeHideFlags = removeHideFlags
			_activeFlags = selection
		}

		public var body: some View {
			LabeledContent {
				Menu(activeFlags: $activeFlags, onRemove: removeHideFlags)
					.fixedSize()
			} label: {
				// TODO: display app icon

				Text(verbatim: application.displayName)
					.lineLimit(1)
					.truncationMode(.tail)
					.help(application.bundleIdentifier)
			}
		}
	}
}
