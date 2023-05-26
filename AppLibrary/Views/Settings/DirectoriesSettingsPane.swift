import SwiftUI
import Settings

struct DirectoriesSettingsPane: View {
	@ObservedObject private var settings: AppSettings = .shared

	var body: some View {
		Settings.Container(contentWidth: 400.0) {
		}
	}
}
