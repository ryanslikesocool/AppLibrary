import SwiftUI

struct AppTile: View {
	var body: some View {
		Button(action: openApplication) {
			HStack {
				//			Image("AppIcon")
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.frame(width: 44, height: 44)

				Text("App Name")

				Spacer()
			}
			.padding(.horizontal, 8)
			.padding(.vertical, 8)
			.redacted(reason: .placeholder)
			.contentShape(containerShape)
		}
		.buttonStyle(.plain)
		.contextMenu {
			Button("Open", action: openApplication)

			Button("Show in Finder", action: showInFinder)

			Button("Hide in List", action: hideInList)
		}
	}

	private var containerShape: some Shape {
		RoundedRectangle(cornerRadius: 12, style: .continuous)
	}

	private func openApplication() { }

	private func showInFinder() { }

	private func hideInList() { }
}
