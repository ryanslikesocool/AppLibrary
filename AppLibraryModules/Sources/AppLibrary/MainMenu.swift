import AppLibraryCommonViews
import OSLog
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
	}
}

// MARK: - Constants

extension MainMenu {
	static let logger = Logger(category: Self.self)
}
