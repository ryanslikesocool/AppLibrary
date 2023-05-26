import SwiftUI

struct AppListView: View {
	let apps: [ApplicationInformation]

	var body: some View {
		ScrollView {
			Spacer()
				.frame(height: 52)

			LazyVStack(alignment: .leading, spacing: 0) {
				ForEach(apps) { app in
					ListTile(app: app)
				}
			}

			Spacer()
				.frame(height: 8)
		}
		.scrollIndicators(.never)
		.padding(.horizontal, 8)
	}
}
