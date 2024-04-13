import AppLibraryStorage
import SwiftUI

extension DisplayPane {
	struct AppearanceSection: View {
		@Binding var model: AppSettings.Display

		var body: some View {
			Section {
				appearancePicker
				reduceMotionToggle
				reduceTransparencyToggle
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
		Text("Any modified system-level accessibility settings will take priority.")
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

	var reduceMotionToggle: some View {
		Toggle(isOn: $model.reduceMotion) {
			Text("Reduce Motion")
			Text("Reduce motion, such as when jumping to letters in the launcher.")
		}
	}

	var reduceTransparencyToggle: some View {
		Toggle(isOn: $model.reduceTransparency) {
			Text("Reduce Transparency")
			Text("Reduce the transparency of the launcher background.")
		}
	}
}
