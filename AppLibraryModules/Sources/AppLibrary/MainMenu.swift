import AppLibraryCommonViews
import SwiftUI

struct MainMenu: Commands {
	public init() { }

	public var body: some Commands {
		CommandGroup(after: .textEditing) {
			FindButton()
		}

		CommandGroup(after: .toolbar) {
			RefreshButton()
		}

		CommandGroup(replacing: .singleWindowList) {
			BrowserWindowLink()
		}
	}
}
