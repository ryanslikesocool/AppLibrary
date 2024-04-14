import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct GridDisplay: View {
		let application: Application

		var body: some View {
			VStack(alignment: .center, spacing: 4) {
				Icon(application: application)
				Label(application: application)
			}
			.contentShape(Rectangle())
			.multilineTextAlignment(.center)
			.contentShape(containerShape)
		}
	}
}

// MARK: - Supporting Views

private extension AppTile.GridDisplay {
	var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: 12)
	}
}
