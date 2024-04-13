import AppLibraryStorage
import SwiftUI

extension AppsPane {
	struct HiddenAppsList: View {
		@Binding var model: AppSettings.Apps

		var body: some View {
			Section {
				if model.hiddenApps.isEmpty {
					noAppsLabel
				} else {
					listContent
				}
			} header: {
				sectionHeader
			}
		}
	}
}

// MARK: - Supporting Views

private extension AppsPane.HiddenAppsList {
	var noAppsLabel: some View {
		Text("No hidden apps...")
	}

	var listContent: some View {
		ForEach(model.hiddenApps.sorted(), content: listItem)
	}

	func listItem(withIdentifier appIdentifier: ApplicationIdentifier) -> some View {
		return LabeledContent {
			Menu("Options", systemImage: "ellipsis.circle") {
				optionMenuContent(withIdentifier: appIdentifier)
			}
			.labelStyle(.iconOnly)
			.fixedSize()
			.menuIndicator(.hidden)
			.buttonStyle(.plain)
		} label: {
			Text(appIdentifier.displayName)
				.lineLimit(1)
				.truncationMode(.tail)
				.help(appIdentifier.bundleIdentifier)
		}
	}

	@ViewBuilder var sectionHeader: some View {
		Text("Hidden Apps")
		Text("""
		Apps listed here will not appear in the App Library.
		Apps can be hidden by right-clicking on one in the App Library and selecting "Hide".
		""")
	}
}

// MARK: - Functions

private extension AppsPane.HiddenAppsList {
	func optionMenuContent(withIdentifier appIdentifier: ApplicationIdentifier) -> some View {
		Group {
			Button("Show", systemImage: "eye") { model.removeHiddenApp(withIdentifier: appIdentifier) }
		}
		.labelStyle(.titleAndIcon)
	}
}
