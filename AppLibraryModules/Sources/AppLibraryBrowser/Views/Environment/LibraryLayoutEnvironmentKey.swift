import AppLibraryStorage
import SwiftUI

extension EnvironmentValues {
	fileprivate(set) var libraryLayout: LibraryLayout {
		get { self[__Key_libraryLayout.self] }
		set { self[__Key_libraryLayout.self] = newValue }
	}

	private enum __Key_libraryLayout: EnvironmentKey {
		static let defaultValue: LibraryLayout = .list
	}
}

extension View {
	func libraryLayout(_ value: LibraryLayout) -> some View {
		environment(\.libraryLayout, value)
	}
}
