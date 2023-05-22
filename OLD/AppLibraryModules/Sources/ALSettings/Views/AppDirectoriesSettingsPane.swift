import MoreWindows
import SwiftUI

struct AppDirectoriesSettingsPane: SettingsPaneView {
	@Binding var settings: AppSettings.AppDirectories

	private var directoryURLs: [URL] {
		settings.appDirectories
			.compactMap { $0.url }.sorted(by: \.relativePath)
	}

	private var recommendedDirectories: [AppSettings.AppDirectories.RecommendedDirectory] {
		AppSettings.AppDirectories.recommendedDirectories
			.filter { recommendation in
				!settings.appDirectories
					.contains(where: { $0.url == recommendation.url })
			}
	}

	init(_ settings: Binding<AppSettings.AppDirectories>) {
		_settings = settings
	}

	var content: some View {
		Text("App Library requires explicit permission from you before it is able to view the contents of directories.")

		Section {
			if directoryURLs.isEmpty {
				Text("No application directories have been added.")
					.opacity(0.5)
			} else {
				LazyVStack {
					let urls = directoryURLs

					ForEach(urls, id: \.self) { url in
						ButtonItem(url.compressingTildeInPath) {
							Button("Remove") {
								guard let index = settings.appDirectories.firstIndex(where: { $0.url == url }) else {
									return
								}
								settings.appDirectories.remove(at: index)
							}
							.help("Remove this app directory.")
							.fontDesign(.default)
						}

						if url != urls.last {
							Divider()
						}
					}
					.fontDesign(.monospaced)
				}
			}
		} header: {
			HStack {
				Text("Application Directories")
				Spacer()
				Button("Add") { settings.promptForDirectory() }
					.font(.body)
					.help("Add a directory to search for applications.")
			}
			Text("Each Application Directory is scanned for apps to display in the App Library.  Subdirectories are not scanned.")
		}

		Section {
			if recommendedDirectories.isEmpty {
				Text("All recommendations have been added.")
					.opacity(0.5)
			} else {
				ForEach(recommendedDirectories, id: \.self) { recommendation in
					ButtonItem(recommendation.url.path(percentEncoded: false)) {
						Button("Add") { settings.promptForDirectory(recommendation.url) }
							.help("Add this recommended directory to the application directory list.")
							.fontDesign(.default)
					}
				}
				.fontDesign(.monospaced)
			}
		} header: {
			Text("Recommended Directories")
			Text("These directories are recommended for the best experience using App Library.")
		}
	}
}
