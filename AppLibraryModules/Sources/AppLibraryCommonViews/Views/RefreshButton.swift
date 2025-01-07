import AppLibraryCommon
import SFSymbolToolbox
import SwiftUI

/// A button that invokes the ``Event/refreshApps`` event.
public struct RefreshButton<Label>: View where
	Label: View
{
	private let label: Label

	public init(@ViewBuilder label: () -> Label) {
		self.label = label()
	}

	public var body: some View {
		Button(action: buttonAction) {
			label
		}
		.keyboardShortcut(.refresh)
	}
}

// MARK: - Functions

private extension RefreshButton {
	func buttonAction() {
		Event.refreshApps.send()
	}
}

// MARK: - Convenience

public extension RefreshButton where
	Label == SwiftUI.Label<Text, Image>
{
	init<S>(
		_ title: S,
		systemImage: String
	) where
		S: StringProtocol
	{
		self.init {
			Label(
				title,
				systemImage: systemImage
			)
		}
	}

	init<S>(
		_ title: S,
		systemImage: SystemSymbolName
	) where
		S: StringProtocol
	{
		self.init {
			Label(
				title,
				systemImage: systemImage
			)
		}
	}

	init(
		_ titleKey: LocalizedStringKey,
		systemImage: String
	) {
		self.init {
			Label(
				titleKey,
				systemImage: systemImage
			)
		}
	}

	init(
		_ titleKey: LocalizedStringKey,
		systemImage: SystemSymbolName
	) {
		self.init {
			Label(
				titleKey,
				systemImage: systemImage
			)
		}
	}

	init(
		_ title: LocalizedStringResource,
		systemImage: String
	) {
		self.init {
			Label(
				title,
				systemImage: systemImage
			)
		}
	}

	init(
		_ title: LocalizedStringResource,
		systemImage: SystemSymbolName
	) {
		self.init {
			Label(
				String(localized: title),
				systemImage: systemImage
			)
		}
	}

	init() {
		self.init(
			String(localized: .common.action.refresh),
			systemImage: .arrow_clockwise
		)
	}
}
