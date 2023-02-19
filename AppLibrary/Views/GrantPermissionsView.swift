import SwiftUI

struct GrantPermissionsView: View {
	@EnvironmentObject private var appDelegate: AppDelegate

	var body: some View {
		VStack {
			Text("Add a directory to\nsearch for applications.")
				.multilineTextAlignment(.center)

			Button("Add Directory") { appDelegate.state.bookmarks.promptForDirectory() }
				.controlSize(.large)
				.buttonStyle(.borderedProminent)

			Text("More directories can be added\nlater in the Settings window.")
				.multilineTextAlignment(.center)
				.opacity(0.666)
				.font(.footnote)
		}
		.fixedSize()
		.padding(32)
	}
}
