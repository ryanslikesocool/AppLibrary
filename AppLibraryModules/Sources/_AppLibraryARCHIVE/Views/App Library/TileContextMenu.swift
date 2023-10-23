import SwiftUI

struct TileContextMenu: View {
	let app: ApplicationInformation

	var body: some View {
		Button("Open", action: app.open)

		Divider()

		Button("Show in Finder", action: app.showInFinder)

		Button("Hide in Library", action: app.hide)
	}
}
