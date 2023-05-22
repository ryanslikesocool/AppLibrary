import Foundation
import SwiftUI

enum LibraryStyle {
	case tile
	case list
}

private struct LibraryStyleKey: EnvironmentKey {
	static let defaultValue = LibraryStyle.tile
}

extension EnvironmentValues {
	var libraryStyle: LibraryStyle {
		get { self[LibraryStyleKey.self] }
		set { self[LibraryStyleKey.self] = newValue }
	}
}

extension View {
	func libraryStyle(_ style: LibraryStyle) -> some View {
		environment(\.libraryStyle, style)
	}
}
