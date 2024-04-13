import AppLibraryStorage
import SwiftUI

extension AppsPane {
	struct HiddenAppsList: View {
		@Binding var model: AppSettings.Apps

		var body: some View {
			Section {
				if model.hiddenApps.isEmpty {
					emptyListLabel
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
	var emptyListLabel: some View {
		Text("No hidden apps...")
			.foregroundStyle(.secondary)
	}

	var listContent: some View {
		ForEach(model.hiddenApps.sorted(), content: listElement)
	}

	func listElement(for appIdentifier: ApplicationIdentifier) -> some View {
		return LabeledContent {
			Menu("Options", systemImage: "ellipsis.circle") {
				optionMenuContent(for: appIdentifier)
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

	func optionMenuContent(for appIdentifier: ApplicationIdentifier) -> some View {
		Group {
			Button("Show", systemImage: "eye") { model.removeHiddenApp(withIdentifier: appIdentifier) }
		}
		.labelStyle(.titleOnly)
	}
}
