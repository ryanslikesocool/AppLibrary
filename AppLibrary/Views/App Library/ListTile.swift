import SwiftUI

struct ListTile: View {
	private static let iconAxis: Int = 44
	private static let iconSize: CGSize = CGSize(width: iconAxis, height: iconAxis)
//	private static let borderStrokeWidth: Double = 2

	let app: ApplicationInformation
//	let isSelected: Bool

//	@State private var contextVisible: Bool = false

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
					.shadow(color: .black.opacity(0.125), radius: 4, y: 2)

				Text(label)
					.font(.body)

				Spacer()
			}
			.padding(.horizontal, 4)
			.padding(.vertical, 4)
			.contentShape(containerShape)
		}
		.buttonStyle(.plain)
//		.background(.selection.opacity(isSelected ? 1 : 0), in: containerShape)
//		.background(.selection.opacity(contextVisible ? 1 : 0), in: containerShape.inset(by: Self.borderStrokeWidth * 0.5).stroke(lineWidth: Self.borderStrokeWidth))
		.contextMenu {
			TileContextMenu(app: app)
//				.onAppear { contextVisible = true }
//				.onDisappear { contextVisible = false }
		}
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: 8, style: .continuous)
	}
}
