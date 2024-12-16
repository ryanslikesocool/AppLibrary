import AppLibraryStorage
import LocalizationTable
import SwiftUI

extension ApplicationHideFlagsList.Item {
	struct Menu: View {
		public typealias SelectionValue = ApplicationHideFlag.Set

		@Binding private var activeFlags: SelectionValue
		private let removeHideFlags: () -> Void

		public init(activeFlags: Binding<SelectionValue>, onRemove removeHideFlags: @escaping () -> Void) {
			_activeFlags = activeFlags
			self.removeHideFlags = removeHideFlags
		}

		public var body: some View {
			SwiftUI.Menu {
				Section {
					makeToggle(.hiddenInBrowser)
						.disabled(true)

					makeToggle(.hiddenInSearch)
				}

				Divider()

				RemoveHideFlagsButton(action: removeHideFlags)
			} label: {
				Text(verbatim: Self.labelText(for: activeFlags))
			}
			.onChange(of: activeFlags, onActiveFlagsChanged)
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationHideFlagsList.Item.Menu {
	func makeToggle(_ flag: ApplicationHideFlag) -> some View {
		ApplicationHideFlagsList.Item.HideFlagToggle(flag.flagLabel, isOn: $activeFlags[SelectionValue(flag)])
	}
}

// MARK: - Functions

private extension ApplicationHideFlagsList.Item.Menu {
	static func labelText(for hideFlags: ApplicationHideFlag.Set) -> String {
		let items = hideFlags.components
			.map { item in
				String(localized: item.flagLabel)
			}
		let itemList = ListFormatter.localizedString(byJoining: items)

		let text = String(localized: .applicationHideFlagsList.item.format.adjective(itemList))

		return text
	}

	func onActiveFlagsChanged() {
		if !activeFlags.contains(.hiddenInBrowser) {
			removeHideFlags()
		}
	}
}

// MARK: -

private extension ApplicationHideFlag {
	var flagLabel: LocalizedStringResource {
		switch self {
			case .hiddenInBrowser: .applicationHideFlagsList.item.browser
			case .hiddenInSearch: .applicationHideFlagsList.item.search
		}
	}
}
