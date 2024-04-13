import AppLibraryStorage
import SwiftUI

extension DisplayPane {
	struct AppearanceSection: View {
		@Binding var model: AppSettings.Display

		var body: some View {
			Section {
				appearancePicker
				reduceTransparencyToggle
			} header: {
				sectionHeader
			}
		}
	}
}

// MARK: - Supporting Views

private extension DisplayPane.AppearanceSection {
	var sectionHeader: some View {
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

	var reduceTransparencyToggle: some View {
		Toggle(isOn: $model.reduceTransparency) {
			Text("Reduce Transparency")
			Text("Reduces the transparency of the launcher background.")
		}
	}
}
