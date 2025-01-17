import AppLibraryStorage
import SwiftUI

extension ApplicationVisibilityList.Item {
	struct Menu: View {
		public typealias SelectionValue = ApplicationVisibility.Set

		@Environment(\.removeVisibilityFlagsAction) private var removeVisibilityFlagsAction
		@Environment(\.applicationModelIdentifier) private var applicationModelIdentifier

		@Binding private var activeFlags: SelectionValue

		public init(activeFlags: Binding<SelectionValue>) {
			_activeFlags = activeFlags
		}

		public var body: some View {
			SwiftUI.Menu(
				activeFlags.menuLabelText
			) {
				makeToggle(.browser)
				makeToggle(.searchResults)
			}
			.onChange(of: activeFlags, onActiveFlagsChanged)
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationVisibilityList.Item.Menu {
	func makeToggle(_ flag: ApplicationVisibility) -> some View {
		ApplicationVisibilityList.Item.VisibilityFlagToggle(
			flag.localizedStringResource,
			isOn: $activeFlags[SelectionValue(flag)]
		)
	}
}

// MARK: - Functions

private extension ApplicationVisibilityList.Item.Menu {
	func onActiveFlagsChanged() {
		if activeFlags == .all {
			removeVisibilityFlagsAction(applicationModelIdentifier)
		}
	}
}

// MARK: -

private extension ApplicationVisibility.Set {
	var menuLabelText: String {
		switch self {
			case .none:
				return String(localized: .applicationVisibilityList.item.hidden)
			case .all:
				return String(localized: .applicationVisibilityList.item.visible)
			default:
				let items = elements
					.map { item in
						String(localized: item.localizedStringResource)
					}
				let itemList = ListFormatter.localizedString(byJoining: items)
				return LocalizedStringResource.applicationVisibilityList.item.format.pastParticiple(itemList)
		}
	}
}
