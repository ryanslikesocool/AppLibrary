import AppLibraryStorage
import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var libraryLayout: LibraryLayout = .list
}

// MARK: - Convenience

extension View {
	func libraryLayout(_ layout: LibraryLayout) -> some View {
		environment(\.libraryLayout, layout)
	}
}
