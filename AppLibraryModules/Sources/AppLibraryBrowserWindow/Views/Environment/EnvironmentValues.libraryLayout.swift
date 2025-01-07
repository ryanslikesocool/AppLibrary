import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var libraryLayout: LibraryLayout = .list
}

// MARK: - Convenience

extension View {
	nonisolated func libraryLayout(_ layout: LibraryLayout) -> some View {
		environment(\.libraryLayout, layout)
			.applicationLabelStyle(layout.applicationLabelStyle)
	}
}
