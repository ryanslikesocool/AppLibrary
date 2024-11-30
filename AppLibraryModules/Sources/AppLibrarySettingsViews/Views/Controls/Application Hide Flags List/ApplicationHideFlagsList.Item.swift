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
				menu()
			} label: {
				Text(application.displayName)
					.lineLimit(1)
					.truncationMode(.tail)
					.help(application.bundleIdentifier)
			}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationHideFlagsList.Item {
	func menu() -> some View {
		Menu {
			Section {
				Toggle("Hide in Search", isOn: $activeFlags[.hiddenInSearch])
			}
			.onChange(of: activeFlags) {
				if !activeFlags.contains(.hiddenInBrowser) {
					removeHideFlags()
				}
			}

			Button("Reveal", systemImage: Constant.Symbol.eye, action: removeHideFlags)
		} label: {
			Text(getHideFlagsText(activeFlags))
		}
		.fixedSize()
	}
}

// MARK: - Functions

private extension ApplicationHideFlagsList.Item {
	func getHideFlagsText(_ hideFlags: SelectionValue) -> String {
		var elements: [String] = []
		if hideFlags.contains(.hiddenInBrowser) {
			elements.append("Browser")
		}
		if hideFlags.contains(.hiddenInSearch) {
			elements.append("Search")
		}

		return "Hidden in \(elements.joined(separator: ", "))"
	}
}
