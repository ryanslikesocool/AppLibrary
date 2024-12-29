import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension ApplicationHideFlagsList {
	struct Item: View {
		public typealias SelectionValue = ApplicationHideFlag.Set

		private let displayName: String
		private let applicationModelIdentifier: ApplicationModelIdentifier
		@Binding private var activeFlags: SelectionValue

		public init?(
			applicationModelIdentifier: ApplicationModelIdentifier,
			selection: Binding<SelectionValue>
		) {
			guard let displayName = ApplicationCache.shared.applications[applicationModelIdentifier]?.displayName else {
				return nil
			}

			self.displayName = displayName
			self.applicationModelIdentifier = applicationModelIdentifier
			_activeFlags = selection
		}

		public var body: some View {
			LabeledContent {
				Menu(activeFlags: $activeFlags, applicationModelIdentifier: applicationModelIdentifier)
					.fixedSize()
			} label: {
				Label {
					Text(verbatim: displayName)
						.lineLimit(1)
						.truncationMode(.tail)
						.help(applicationModelIdentifier.bundleIdentifier)
				} icon: {
					if let nsImage = ApplicationCache.shared.applications[applicationModelIdentifier]?.getLatestIcon() {
						Image(nsImage: nsImage)
							.resizable()
							.frame(width: 16, height: 16)
					}
				}
			}
		}
	}
}
