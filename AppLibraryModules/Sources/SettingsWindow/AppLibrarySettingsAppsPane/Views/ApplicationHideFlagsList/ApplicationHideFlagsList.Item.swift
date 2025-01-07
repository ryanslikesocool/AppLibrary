import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension ApplicationHideFlagsList {
	struct Item: View {
		public typealias SelectionValue = ApplicationHideFlag.Set

		@Environment(\.applicationModelIdentifier) private var applicationModelIdentifier

		@Binding private var activeFlags: SelectionValue

		public init(selection: Binding<SelectionValue>) {
			_activeFlags = selection
		}

		public var body: some View {
			LabeledContent {
				Menu(activeFlags: $activeFlags)
					.fixedSize()
			} label: {
				ApplicationLabel(for: applicationModelIdentifier)
			}
			.contextMenu {
				ContextMenu()
			}
		}
	}
}
