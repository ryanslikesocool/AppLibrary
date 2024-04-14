import AppLibraryStorage
import SwiftUI

extension DisplayPane {
	struct AppearanceSection: View {
		@Binding var model: AppSettings.Display

		var body: some View {
			Section {
				appearancePicker
			} header: {
				sectionHeader
			}
		}
	}
}

// MARK: - Supporting Views

private extension DisplayPane.AppearanceSection {
	@ViewBuilder var sectionHeader: some View {
		Text("Appearance")
	}

	var appearancePicker: some View {
		Picker("Appearance", selection: $model.appearance) {
			Text(Appearance.system.description).tag(Appearance.system)
			Section {
				Text(Appearance.light.description).tag(Appearance.light)
				Text(Appearance.dark.description).tag(Appearance.dark)
			}
		}
		.onChange(of: model.appearance) {
			NSApp.appearance = model.appearance.nsApperance
		}
	}
}
