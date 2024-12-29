import AppLibraryStorage
import SwiftUI

extension ApplicationHideFlagsList.Item {
	struct Menu: View {
		public typealias SelectionValue = ApplicationHideFlag.Set

		@Environment(\.removeHideFlagsAction) private var removeHideFlagsAction

		@Binding private var activeFlags: SelectionValue
		private let applicationModelIdentifier: ApplicationModelIdentifier

		public init(activeFlags: Binding<SelectionValue>, applicationModelIdentifier: ApplicationModelIdentifier) {
			_activeFlags = activeFlags
			self.applicationModelIdentifier = applicationModelIdentifier
		}

		public var body: some View {
			SwiftUI.Menu {
				makeToggle(.hiddenInBrowser)
				makeToggle(.hiddenInSearch)
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
		if hideFlags.isEmpty {
			return String(localized: .applicationHideFlagsList.item.notHidden)
		} else {
			let items = hideFlags.components
				.map { item in
					String(localized: item.flagLabel)
				}
			let itemList = ListFormatter.localizedString(byJoining: items)
			return String(localized: .applicationHideFlagsList.item.format.adjective(itemList))
		}
	}

	func onActiveFlagsChanged() {
		if !activeFlags.contains(.hiddenInBrowser) {
			removeHideFlagsAction(applicationModelIdentifier)
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
