import AppLibraryStorage
import SwiftUI

private enum LibraryLayoutEnvironmentKey: EnvironmentKey {
	static var defaultValue: LibraryLayout = .list
}

public extension EnvironmentValues {
	fileprivate(set) var libraryLayout: LibraryLayout {
		get { self[LibraryLayoutEnvironmentKey.self] }
		set { self[LibraryLayoutEnvironmentKey.self] = newValue }
	}
}

public extension View {
	func libraryLayout(_ libraryLayout: LibraryLayout) -> some View {
		environment(\.libraryLayout, libraryLayout)
	}
}
