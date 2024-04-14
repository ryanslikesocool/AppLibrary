import AppLibraryStorage
import SwiftUI

extension DisplayPane {
	struct AccessibilitySection: View {
		@Binding var model: AppSettings.Display

		var body: some View {
			Section {
				reduceMotionToggle
				reduceTransparencyToggle
			} header: {
				sectionHeader
			}
		}
	}
}

private extension DisplayPane.AccessibilitySection {
	@ViewBuilder var sectionHeader: some View {
		Text("Accessibility")
		Text("Any modified system-level accessibility settings will take priority.")
	}

	var reduceMotionToggle: some View {
		Toggle(isOn: $model.reduceMotion) {
			Text("Reduce Motion")
			Text("Reduce motion when jumping to letters in the launcher.")
		}
	}

	var reduceTransparencyToggle: some View {
		Toggle(isOn: $model.reduceTransparency) {
			Text("Reduce Transparency")
			Text("Reduce the transparency of the launcher background and search field.")
		}
	}
}
