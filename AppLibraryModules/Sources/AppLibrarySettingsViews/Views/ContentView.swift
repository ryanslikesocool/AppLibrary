import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct ContentView: View {
	@State private var tabSelection: SettingsCategory = .general

	var body: some View {
		TabView(selection: $tabSelection) {
			GeneralPane()
			LayoutPane()
			LocationPane()
			AppsPane()
		}
		.frame(width: 450)
		.frame(maxHeight: 500)
		.fixedSize()
		.formStyle(.grouped)

		.onReceive(Event.goToSettingsTab) { tab in
			tabSelection = tab
		}
	}
}
