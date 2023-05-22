import SwiftUI

struct GrantPermissionsView: View {
	@EnvironmentObject private var appDelegate: AppDelegate

	var body: some View {
		VStack {
			Text("Add a directory to\nsearch for applications.")
				.multilineTextAlignment(.center)

			Button("Add Directory") { appDelegate.settings.appDirectories.promptForDirectory() }
				.controlSize(.large)
				.buttonStyle(.borderedProminent)

			Text("More directories can be added\nin the Settings pane.")
				.multilineTextAlignment(.center)
				.opacity(0.666)
				.font(.footnote)
		}
		.fixedSize()
		.padding(32)
	}
}
