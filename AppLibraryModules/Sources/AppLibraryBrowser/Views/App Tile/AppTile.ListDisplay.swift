import AppLibraryStorage
import SwiftUI

extension AppTile {
	struct ListDisplay: View {
		let application: Application

		var body: some View {
			HStack {
				Icon(application: application)
				Label(application: application)
				Spacer()
			}
			.contentShape(Rectangle())
		}
	}
}
