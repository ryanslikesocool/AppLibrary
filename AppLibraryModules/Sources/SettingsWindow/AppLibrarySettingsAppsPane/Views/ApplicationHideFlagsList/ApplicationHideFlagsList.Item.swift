import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension ApplicationHideFlagsList {
	struct Item: View {
		public typealias ItemIdentifier = ApplicationModelIdentifier
		public typealias SelectionValue = ApplicationHideFlag.Set

		private let displayName: String
		private let itemIdentifier: ItemIdentifier
		@Binding private var activeFlags: SelectionValue
		private let removeHideFlags: () -> Void

		public init?(
			application itemIdentifier: ItemIdentifier,
			selection: Binding<SelectionValue>,
			onRemove removeHideFlags: @escaping () -> Void
		) {
			guard let displayName = ApplicationCache.shared.applications[itemIdentifier]?.displayName else {
				return nil
			}

			self.displayName = displayName
			self.itemIdentifier = itemIdentifier
			self.removeHideFlags = removeHideFlags
			_activeFlags = selection
		}

		public var body: some View {
			LabeledContent {
				Menu(activeFlags: $activeFlags, onRemove: removeHideFlags)
					.fixedSize()
			} label: {
				// TODO: display app icon

				Text(verbatim: displayName)
					.lineLimit(1)
					.truncationMode(.tail)
					.help(itemIdentifier.bundleIdentifier)
			}
		}
	}
}
