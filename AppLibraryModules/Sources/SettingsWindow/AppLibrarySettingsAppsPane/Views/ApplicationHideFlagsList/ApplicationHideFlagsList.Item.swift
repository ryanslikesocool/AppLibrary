import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension ApplicationHideFlagsList {
	struct Item: View {
		public typealias SelectionValue = ApplicationHideFlag.Set

		@Environment(\.applicationModelIdentifier) private var applicationModelIdentifier
		@Environment(\.applicationModel) private var applicationModel

		@Binding private var activeFlags: SelectionValue

		public init(selection: Binding<SelectionValue>) {
			_activeFlags = selection
		}

		public var body: some View {
			if let displayName = applicationModel?.displayName {
				LabeledContent {
					Menu(activeFlags: $activeFlags)
						.fixedSize()
				} label: {
					makeLabel(displayName: displayName)
				}
				.contextMenu {
					ContextMenu()
				}
			}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationHideFlagsList.Item {
	func makeLabel(displayName: String) -> some View {
		Label {
			Text(verbatim: displayName)
				.lineLimit(1)
				.truncationMode(.tail)
				.help(applicationModelIdentifier.bundleIdentifier)
		} icon: {
			Image(applicationIcon: applicationModel)
				.resizable()
				.aspectRatio(contentMode: .fit)
		}
	}
}
