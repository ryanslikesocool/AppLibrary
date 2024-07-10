import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension AppsPane.HideFlagsList {
	struct Item: View {
		@ObservedObject private var model: AppsSettings

		private let application: ApplicationIdentifier
		@Binding private var activeFlags: ApplicationHideFlags

		init(model: AppsSettings, application: ApplicationIdentifier) {
			self.model = model
			self.application = application

			_activeFlags = Binding(
				get: { model.applicationHideFlags[application] ?? .none },
				set: { model.applicationHideFlags[application] = $0 }
			)
		}

		var body: some View {
			return LabeledContent {
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

private extension AppsPane.HideFlagsList.Item {
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

private extension AppsPane.HideFlagsList.Item {
	func getHideFlagsText(_ hideFlags: ApplicationHideFlags) -> String {
		var elements: [String] = []
		if hideFlags.contains(.hiddenInBrowser) {
			elements.append("Browser")
		}
		if hideFlags.contains(.hiddenInSearch) {
			elements.append("Search")
		}

		return "Hidden in \(elements.joined(separator: ", "))"
	}

	func removeHideFlags() {
		model.removeApplicationHideFlags(for: application)
	}
}
