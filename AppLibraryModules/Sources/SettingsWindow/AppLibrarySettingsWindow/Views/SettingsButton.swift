import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
internal import SettingsAccess
import SwiftUI

public struct SettingsButton<Label>: View where
	Label: View
{
	@Environment(\.openSettingsLegacy) private var openSettings

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
		do {
			try openSettings()

			if let destination {
				Event.goToSettingsTab.send(destination)
			}
		} catch {
			Logger.module.error("""
			Failed to open settings window:
			\(error.localizedDescription)
			""")
		}
	}
}

// MARK: - Convenience

public extension SettingsButton where
	Label == SwiftUI.Label<Text, Image>
{
	init(destination: SettingsCategory? = nil) {
		self.init(destination: destination) {
			Label {
				Text("LINK.SETTINGS", table: .common)
			} icon: {
				Image(systemName: Constant.Symbol.gear)
			}
		}
	}
}
