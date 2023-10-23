import SwiftUI

struct AppListView: View {
	let apps: [ApplicationInformation]
//	@State private var selection: ApplicationInformation.ID? = nil

	var body: some View {
		ScrollView(showsIndicators: false) {
			LazyVStack(alignment: .leading, spacing: 0) {
				Spacer()
					.frame(height: 52)

				ForEach(apps) { app in
					// ListTile(app: app, isSelected: selection == app.id)
					ListTile(app: app)
				}

				Spacer()
					.frame(height: 8)
			}
		}
		.scrollIndicators(.never)
		.padding(.horizontal, 8)
	}
}
