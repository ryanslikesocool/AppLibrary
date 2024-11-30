import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import LocalizationTable
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
				HiddenInSearchToggle(isOn: $activeFlags[.hiddenInSearch])
			}
			.onChange(of: activeFlags, onActiveFlagsChanged)

			RemoveHideFlagsButton(action: removeHideFlags)
		} label: {
			Text(getHideFlagsText(activeFlags))
		}
		.fixedSize()
	}
}

// MARK: - Functions

private extension ApplicationHideFlagsList.Item {
	func getHideFlagsText(_ hideFlags: SelectionValue) -> String {
		let localizationTable: LocalizationTableResource = .applicationHideFlagsList

		let items = hideFlags.components
			.map { item in
				String(localized: item.flagLabelKey, table: localizationTable)
			}
			.joined(separator:
				String(localized: "ITEM.FLAGS_DESCRIPTION.SEPARATOR", table: localizationTable)
			)

		return String(localized: "ITEM.FLAGS_DESCRIPTION.FORMAT_\(items)", table: localizationTable)
	}

	func onActiveFlagsChanged() {
		if !activeFlags.contains(.hiddenInBrowser) {
			removeHideFlags()
		}
	}
}

// MARK: -

private extension ApplicationHideFlag {
	var flagLabelKey: String.LocalizationValue {
		switch self {
			case .hiddenInBrowser: "FLAG.BROWSER.LABEL"
			case .hiddenInSearch: "FLAG.SEARCH.LABEL"
		}
	}
}