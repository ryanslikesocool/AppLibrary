import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct ContentView: View {
	@State private var tabSelection: SettingsCategory = .general

	public init() { }

	public var body: some View {
		content
			.frame(width: Self.contentWidth)
			.frame(maxHeight: Self.contentMaxHeight)
			.fixedSize()
			.formStyle(.grouped)

			.onReceive(Event.goToSettingsTab) { tab in
				tabSelection = tab
			}
	}
}

// MARK: - Supporting Views

private extension ContentView {
	@ViewBuilder
	var content: some View {
		if #available(macOS 15, *) {
			TabView(selection: $tabSelection) {
				ForEach(Self.tabDisplayOrder) { category in
					Tab(value: category) {
						SettingsTabContent(category: category)
					} label: {
						category.label
					}
				}
			}
		} else {
			TabView(selection: $tabSelection) {
				ForEach(Self.tabDisplayOrder) { category in
					SettingsTabContent(category: category)
						.tabItem { category.label }
						.tag(category)
				}
			}
		}
	}
}

// MARK: - Constants

private extension ContentView {
	static let tabDisplayOrder: [SettingsCategory] = SettingsCategory.allCases

	static let contentWidth: CGFloat = 450
	static let contentMaxHeight: CGFloat = 500
}
