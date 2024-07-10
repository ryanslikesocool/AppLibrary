import AppLibraryStorage
import SwiftUI

extension GeneralPane {
	struct AppearancePicker: View {
		@Binding var selection: Appearance?

		var body: some View {
			Picker("Appearance", selection: $selection) {
				Text("Automatic").tag(Appearance?.none)

				Section {
					Text("Light").tag(Appearance?.some(.light))
					Text("Dark").tag(Appearance?.some(.dark))
				}
			}
			.onChange(of: selection, selection.apply)
		}
	}
}
