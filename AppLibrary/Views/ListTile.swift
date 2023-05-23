import SwiftUI

struct ListTile: View {
	private static let iconAxis: Int = 44
	private static let iconSize: CGSize = CGSize(width: iconAxis, height: iconAxis)

	let app: ApplicationInformation

	private var label: String {
		if app.displayName.hasSuffix(".app") {
			return String(app.displayName.dropLast(4))
		} else {
			return app.displayName
		}
	}

	var body: some View {
		Button(action: app.open) {
			HStack {
				Image(nsImage: app.getIcon())
					.resizable()
					.frame(width: 44, height: 44)

				Text(label)

				Spacer()
			}
			.padding(.horizontal, 8)
			.padding(.vertical, 8)
			.contentShape(containerShape)
		}
		.buttonStyle(.plain)
		.contextMenu {
			TileContextMenu(app: app)
		}
	}

	private var containerShape: some Shape {
		RoundedRectangle(cornerRadius: 12, style: .continuous)
	}
}
