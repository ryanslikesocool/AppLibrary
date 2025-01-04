import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

public struct SettingsButton<Label>: View where
	Label: View
{
	@Environment(\.openSettings) private var openSettings

	private let label: () -> Label
	private let destination: SettingsCategory?

	public init(destination: SettingsCategory? = nil, @ViewBuilder label: @escaping () -> Label) {
		self.destination = destination
		self.label = label
	}

	public var body: some View {
		Button(action: buttonAction, label: label)
	}
}

// MARK: - Functions

private extension SettingsButton {
	func buttonAction() {
		openSettings()

		if let destination {
			Event.goToSettingsTab.send(destination)
		}
	}
}

// MARK: - Convenience

public extension SettingsButton where
	Label == SwiftUI.Label<Text, Image>
{
	init(destination: SettingsCategory? = nil) {
		self.init(destination: destination) {
			Label(
				String(localized: .common.link.settings),
				systemImage: .gear
			)
		}
	}
}
